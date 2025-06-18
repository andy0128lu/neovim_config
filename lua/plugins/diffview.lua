return {
  'sindrets/diffview.nvim',
  keys = {
    { mode = { "n" }, "<leader>vo", "<cmd>DiffviewOpen<cr>", desc = "Open diff view" },
    { mode = { "n" }, "<leader>vp", "<cmd>DiffviewOpen origin/HEAD...HEAD --imply-local<cr>", desc = "Compare the header of current branch with the remote base branch (PR view)" },
    { mode = { "n" }, "<leader>vb", "<cmd>DiffviewFileHistory<cr>", desc = "[V]iew file history for the current [b]ranch" },
    { mode = { "n" }, "<leader>vf", "<cmd>DiffviewFileHistory %<cr>", desc = "[V]iew file history for the current [f]ile" },
  }
}
