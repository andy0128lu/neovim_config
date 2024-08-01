-- File type plugin specifically for cs files which will be loaded after loading the global plugin
-- Set the keymaps only avaialble when cs files are open; otherwise it would break for other file types

vim.keymap.set("n", "gd", "<cmd>lua require('omnisharp_extended').lsp_definition()<cr>", {
  desc =
  "replaces vim.lsp.buf.definition()"
})

vim.keymap.set("n", "gD", "<cmd>lua require('omnisharp_extended').lsp_type_definition()<cr>", {
  desc =
  " replaces vim.lsp.buf.type_definition()"
})

vim.keymap.set("n", "gr", "<cmd>lua require('omnisharp_extended').lsp_references()<cr>", {
  desc =
  "replaces vim.lsp.buf.references()"
})

vim.keymap.set("n", "gi", "<cmd>lua require('omnisharp_extended').lsp_implementation()<cr>", {
  desc =
  "replaces vim.lsp.buf.implementation()"
})
