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
  defaults = {
    keymaps = false, -- lazyvim.config.keymaps
  }
})
-- TODO: Make it load files in a folder automatically
require("customise/keymaps")
require("customise/diagnostic")
require("customise/better-escape")

-- TODO: not working - load files in a folder automaticall
-- -- init.lua or another file where you want to require files from the directory
-- Lazyvim seems loading files automatically. It's worth to check out
-- https://www.lazyvim.org/configuration/general
-- local config_dir = vim.fn.stdpath('config') .. '/lua/customise/'
--
-- -- List all Lua files in the directory
-- for _, file in ipairs(vim.fn.glob(config_dir .. '*.lua', false, true)) do
--   -- Extract the filename without the extension
--   local module_name = file:match('.*/(.-)%.lua$')
--   -- Require the file
--   require('customise/' .. module_name)
-- end
