return {
  "vim-test/vim-test",
  dependencies = {
    "preservim/vimux", -- run tests in spearate pane -- doesn't load, why?
  },
  keys = {
    { "<leader>tn", "<cmd>TestNearest<CR>", desc = "run the test nearest the cursor" },
    { "<leader>tf", "<cmd>TestFile<CR>",    desc = "run all tests in a file" },
    { "<leader>ts", "<cmd>TestSuite<CR>",   desc = "run the whole test suite depending on the test framework" },
  },
  config = function(_, opts) 
    vim.cmd("let test#strategy = 'vimux'")
  end
}
