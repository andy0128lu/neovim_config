return {
  "vim-test/vim-test",
  dependencies = {
    "preservim/vimux", -- run tests in spearate pane -- doesn't load, why?
  },
  keys = {
    { "<leader>tn", ":TestNearest<CR>", desc = "run the test nearest the cursor" },
    { "<leader>tf", ":TestFile<CR>",    desc = "run all tests in a file" },
    { "<leader>ts", ":TestSuite<CR>",   desc = "run the whole test suite depending on the test framework" },
  },
  vim.cmd("let test#strategy = 'vimux'")
}
