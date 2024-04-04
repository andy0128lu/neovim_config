vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

vim.g.mapleader = " "
--vim.opt.foldmethod = "indent"

vim.opt.number = true
vim.opt.relativenumber = true
-- vim.opt.cursorline = true -- highlight the current line number
vim.opt.conceallevel = 2 -- for UI features of obsidian.nvim

---- disable virtual_text (inline) diagnostics and use floating window
---- format the message such that it shows source, message and
---- the error code. Show the message with <space>e
--vim.diagnostic.config({
--  virtual_text = false,
--  signs = true,
--  float = {
--    border = "single",
--    format = function(diagnostic)
--      return string.format(
--        "%s (%s) [%s]",
--        diagnostic.message,
--        diagnostic.source,
--        diagnostic.code or diagnostic.user_data.lsp.code
--      )
--    end,
--  },
--})

vim.keymap.set("n", "<leader>i", ":lua vim.diagnostic.open_float(nil, { focus=true, scope='cursor' })<CR>", { desc = "Show diagnostic in floating window" })

local diagnostics_active = true
local toggle_diagnostics = function()
  diagnostics_active = not diagnostics_active
  if diagnostics_active then
    vim.diagnostic.show()
  else
    vim.diagnostic.hide()
  end
end
vim.keymap.set('n', '<leader>dt', toggle_diagnostics, { desc = "Toggle diagnostic" })

-- settings for plugin: bufferline.
-- When `termguicolors` is enabled, this plugin is designed to work automatically,
-- deriving colours from the user's theme, you can change highlight groups by
vim.opt.termguicolors = true

vim.keymap.set("n", ";", ":", { desc = "Swap ; and :" })
vim.keymap.set("n", ":", ";", { desc = "Swap ; and :" })
vim.keymap.set("n", "<leader>hn", ":nohlsearch<CR>", { desc = "Hide highlight in search result" })

vim.keymap.set("n", "<C-t>", ":terminal<CR>", { desc = "Open terminal mode" })

--vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)

-- Overwrite keymap for navigation between panes in Tmux
vim.keymap.set("n", "<C-h>", ":TmuxNavigateLeft<CR>", { desc = "navigate to left pane" })
vim.keymap.set("n", "<C-l>", ":TmuxNavigateRight<CR>", { desc = "navigate to right pane" })
vim.keymap.set("n", "<C-h>", ":TmuxNavigateDown<CR>", { desc = "navigate to down pane" })
vim.keymap.set("n", "<C-h>", ":TmuxNavigateUp<CR>", { desc = "navigate to up pane" })
