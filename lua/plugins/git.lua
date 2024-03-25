return {
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()

      vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", {})
      vim.keymap.set("n", "<leader>gb", ":Gitsigns toggle_current_line_blame<CR>", {})
    end,
  },
  {
    "tpope/vim-fugitive",
    config = function()
      vim.keymap.set("n", "<leader>gs", ":tab Git<CR>", {})
      vim.keymap.set("n", "<leader>gh", ":Git blame<CR>", {})
      vim.keymap.set("n", "<leader><leader>gpl", ":Git pull<CR>", {})
      vim.keymap.set("n", "<leader><leader>gps", ":Git push<CR>", {})
    end,
  },
}
