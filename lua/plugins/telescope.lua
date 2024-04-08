return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local builtin = require("telescope.builtin")
      local function grep_cword()
        return builtin.grep_string({ search = vim.fn.expand("<cword>") })
      end
      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "find files based on keyword" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Search in the current entire directory" })
      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Search in the current buffer" })
      vim.keymap.set("n", "<leader>fc", grep_cword, { desc = "Search in the current buffer" })
      vim.keymap.set(
        "n",
        "<leader>fs",
        builtin.treesitter,
        { desc = "Lists Function names, variables from Treesitter" }
      )
    end,
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    config = function()
      require("telescope").setup({
        pickers = {
          find_files = {
            find_command = { "rg", "--files", "--glob", "!**/.git/*", "--hidden" },
          },
          grep_string = {
            additional_args = { "--hidden" },
          },
          live_grep = {
            additional_args = { "--hidden" },
          },
          extensions = {
            ["ui-select"] = {
              require("telescope.themes").get_dropdown({}),
            },
          },
        },
      })
      require("telescope").load_extension("ui-select")
    end,
  },
}
