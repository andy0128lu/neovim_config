-- general keymaps
vim.keymap.set("n", ";", ":", { desc = "Swap ; and :" })
vim.keymap.set("n", ":", ";", { desc = "Swap ; and :" })
vim.keymap.set("n", "<leader>hn", ":nohlsearch<CR>", { desc = "Hide highlight in search result" })
vim.keymap.set("n", "<leader>ct", ":tabclose<CR>", { desc = "Close all windows in the current tab" })
vim.keymap.set("n", "<leader>cb", ":tabnew | %bd | b#<CR>", { desc = "Close all buffers but this one" })

--- Move selected lines up and down (Aligning with the indent for the given block, such as within brackets)
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<C-t>", ":terminal<CR>", { desc = "Open terminal mode" })

-- keymaps for LSP
vim.keymap.set("n", "<leader>gl", ":EslintFixAll<CR>", { desc = "Eslint fix all" })
vim.keymap.set("n", "g]", vim.diagnostic.goto_next, { desc = "Go to next diagnostic line" })
vim.keymap.set("n", "g[", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic line" })

-- Handlers
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp", { clear = true }),
  callback = function(args)
    -- Enable completion if LSP server supports
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
    end

    -- keybindings for LSP
    local opts = { buffer = args.buf }
    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover({border = "rounded"})<cr>', opts)
    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
    vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
    vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
    vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
    vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
    vim.keymap.set('n', 'gn', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
    vim.keymap.set("n", 'gf', '<cmd>lua vim.lsp.buf.format()<cr>', { desc = "formatting" })
    vim.keymap.set('n', 'gc', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
    vim.keymap.set({ 'n', 'x' }, 'gf', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
  end
})

-- TODO: commented out for now
-- BufWritePre
--vim.api.nvim_create_autocmd("BufWritePre", {
--  buffer = args.buf,
--  callback = function()
--    -- Formatting on Save
--    vim.lsp.buf.format {
--      async = false,
--      id = args.data.client_id,
--      -- Never request the servers in the list for formatting
--      filter = function(client)
--        local disable_formatting = {
--          ts_ls = true,
--          ruby_lsp = true
--        }
--        return disable_formatting[client.name]
--      end
--    }
--  end,
--})

-- TODO: refactor to an file
-- Quickfix list: delete items
local del_qf_item = function()
  local items = vim.fn.getqflist()
  local line = vim.fn.line('.')
  table.remove(items, line)
  vim.fn.setqflist(items, "r")
  vim.api.nvim_win_set_cursor(0, { line, 0 })
end

vim.keymap.set("n", "<leader>dd", del_qf_item, { silent = true, buffer = true, desc = "Remove entry from QF" })
vim.keymap.set("v", "<leader>D", del_qf_item, { silent = true, buffer = true, desc = "Remove entry from QF" })
