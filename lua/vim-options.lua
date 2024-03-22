vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

vim.g.mapleader = " "
--vim.opt.foldmethod = "indent"

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.conceallevel = 2 -- for UI features of obsidian.nvim

vim.keymap.set("n", ";", ":", { desc = "Swap ; and :" })
vim.keymap.set("n", ":", ";", { desc = "Swap ; and :" })
vim.keymap.set("n", "<leader>hn", ":nohlsearch<CR>", { desc = "Hide highlight in search result" })

vim.keymap.set("n", "<C-t>", ":terminal<CR>", { desc = "Open terminal mode" })

-- Overwrite keymap for navigation between panes in Tmux
vim.keymap.set("n", "<C-h>", ":TmuxNavigateLeft<CR>", { desc = "navigate to left pane" })
vim.keymap.set("n", "<C-l>", ":TmuxNavigateRight<CR>", { desc = "navigate to right pane" })
vim.keymap.set("n", "<C-h>", ":TmuxNavigateDown<CR>", { desc = "navigate to down pane" })
vim.keymap.set("n", "<C-h>", ":TmuxNavigateUp<CR>", { desc = "navigate to up pane" })
