-- Load gloal settings
require("customise/vim-options")

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

-- Load modules
require("lazy").setup({
  spec = {
    -- import from the /plugins directory
    { import = "plugins" },
  },
  defaults = {
    keymaps = false, -- lazyvim.config.keymaps
  }
})

-- Load all configuration files under /lua/customise
local customise_path = vim.fn.stdpath("config") .. "/lua/customise"
for _, file in ipairs(vim.fn.readdir(customise_path)) do
  if file:match("%.lua$") then
    local module_name = "customise." .. file:gsub("%.lua$", "")
    pcall(require, module_name)
  end
end
