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

-- settings for plugin: bufferline.
-- When `termguicolors` is enabled, this plugin is designed to work automatically,
-- deriving colours from the user's theme, you can change highlight groups by
vim.opt.termguicolors = true

-- general keymaps
vim.keymap.set("n", ";", ":", { desc = "Swap ; and :" })
vim.keymap.set("n", ":", ";", { desc = "Swap ; and :" })
vim.keymap.set("n", "<leader>hn", ":nohlsearch<CR>", { desc = "Hide highlight in search result" })

vim.keymap.set("n", "<C-t>", ":terminal<CR>", { desc = "Open terminal mode" })

-- keymaps for LSP
vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, { desc = "formatting" })
vim.keymap.set("n", "<leader>gl", ":EslintFixAll<CR>", { desc = "Eslint fix all" })
vim.keymap.set("n", "g]", vim.diagnostic.goto_next, { desc = "Go to next diagnostic line"})
vim.keymap.set("n", "g[", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic line"})
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "code action list"})

-- Overwrite keymap for navigation between panes in Tmux
vim.keymap.set("n", "<C-h>", ":TmuxNavigateLeft<CR>", { desc = "navigate to left pane" })
vim.keymap.set("n", "<C-l>", ":TmuxNavigateRight<CR>", { desc = "navigate to right pane" })
vim.keymap.set("n", "<C-h>", ":TmuxNavigateDown<CR>", { desc = "navigate to down pane" })
vim.keymap.set("n", "<C-h>", ":TmuxNavigateUp<CR>", { desc = "navigate to up pane" })

-- TODO: refactor to an file
-- Quickfix list: delete items
local del_qf_item = function()
  local items = vim.fn.getqflist()
  local line = vim.fn.line('.')
  table.remove(items, line)
  vim.fn.setqflist(items, "r")
  vim.api.nvim_win_set_cursor(0, { line, 0 })
end

vim.keymap.set("n", "dd", del_qf_item, { silent = true, buffer = true, desc = "Remove entry from QF" })
vim.keymap.set("v", "D", del_qf_item, { silent = true, buffer = true, desc = "Remove entry from QF" })
