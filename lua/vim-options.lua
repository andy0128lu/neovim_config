vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

vim.g.mapleader = " "

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.conceallevel = 2 -- for UI features of obsidian.nvim

vim.keymap.set("n", ";", ":", { desc = "Swap ; and :" })
vim.keymap.set("n", ":", ";", { desc = "Swap ; and :" })
vim.keymap.set("n", "<leader>hn", ":nohlsearch<CR>", { desc = "Hide highlight in search result" })

vim.keymap.set("n", "<C-t>", ":terminal<CR>", { desc = "Open terminal mode" })
