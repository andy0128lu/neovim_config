return {
  {
    -- Copilot completion suggestion
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    cmd = "Copilot",
    config = function()
      -- Set a compatiable version of NodeJS with Copilot. Node.js version must be > 20
      -- TODO: this setup is not working. The current workaround is switch to v20 before entering nvim
      -- vim.g.copilot_node_command = vim.fn.expand("$HOME") .. "/.nvm/versions/node/v20.15.1/bin/node"

      require("copilot").setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
      })
    end,
  },
  {
    -- Add suggestions from Copilot to snippet
    "zbirenbaum/copilot-cmp",
    event = "InsertEnter",
    config = function()
      require("copilot_cmp").setup()
    end,
  },
  {
    -- Enable Copilot chat
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
    },
    build = "make tiktoken",                          -- Only on MacOS or Linux
    keys = {
      { mode = { "n", "v" }, "<leader>cc", "<cmd>CopilotChatToggle<cr>", desc = "Toggle Copilot Chat" },
    },
    opts = {
      window = {
        layout = 'float',
      }
    },
    config = function(_, opts)
      require("CopilotChat").setup(opts)
    end
  }
}
