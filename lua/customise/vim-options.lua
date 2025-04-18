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

-- Handlers
--- BufWritePre
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp", { clear = true }),
  callback = function(args)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = args.buf,
      callback = function()
        -- Formatting on Save
        vim.lsp.buf.format {
          async = false,
          id = args.data.client_id,
          -- Never request typescript-language-server for formatting
          filter = function(client) return client.name ~= "ts_ls" end
        }
      end,
    })
  end
})

-- Config for Ruby
-- Currently I use treesitter to indent my text. However when using the period
-- nvim-treesitter will break my indentation of the current line, leading me to
-- manually fixing each time I use the period/dot character.
-- This is a band-aid to removing the `.` char as an indent key
vim.cmd('autocmd FileType ruby setlocal indentkeys-=.')
