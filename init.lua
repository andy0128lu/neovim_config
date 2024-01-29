vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

-- Install lazy.vim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Prepare plugins
local plugins = {
  { "catppuccin/nvim", lazy = true, name = "catppuccin", priority = 1000 },  
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.5', 
     dependencies = { 'nvim-lua/plenary.nvim' }
  },
  { 'nvim-treesitter/nvim-treesitter', build = ":TSUpdate"},
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    }
  }
}
local opts = {}

-- Load modules
--- lazy: plugins manager
require("lazy").setup(plugins, opts)

--- telescope: fuzzy finding files
local builtin = require("telescope.builtin")
vim.g.mapleader = " "
vim.keymap.set('n', '<leader>ff', builtin.find_files, {}) -- Set shortcut "space + ff" to find files based on keyword
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {}) -- Set shortcut "space + fg" to grap files through projects

--- treesitter: generate abstract syntax tree for parsers to highlight code
local treesitterConfig = require("nvim-treesitter.configs")
treesitterConfig.setup({
  ensure_installed = { "lua", "javascript", "typescript", "ruby", "bash", "markdown", "html", "css", "json", "c_sharp", "sql" },
  highlight = { enable = true },
  indent = { enable = true }
})

--- neo-tree
vim.keymap.set('n', '<leader>n', ':Neotree filesystem reveal left<CR>')

--- catppuccin: colour scheme
vim.g.catppuccin_flavour = "macchiato" -- latte, frappe, macchiato, mocha
require('catppuccin').setup({
 flavour = catppuccin_flavour
})
vim.cmd.colorscheme 'catppuccin'
