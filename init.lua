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
require("customise/vim-options")
require("lazy").setup({
  spec = {
    -- import from the /plugins directory
    { import = "plugins" },
  },
})
-- TODO: Make it load files in a folder automatically
require("customise/keymaps")
require("customise/diagnostic")
require("customise/better-escape")
