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
        panel = {
          enabled = true,
          auto_refresh = false,
          keymap = {
            jump_prev = "[[",
            jump_next = "]]",
            accept = "<CR>",
            refresh = "gr",
            open = "<M-CR>"
          },
          layout = {
            position = "bottom", -- | top | left | right | bottom |
            ratio = 0.4
          },
        },
        suggestion = {
          enabled = true,
          auto_trigger = false,
          hide_during_completion = true,
          debounce = 75,
          trigger_on_accept = true,
          keymap = {
            accept = "<M-l>",
            accept_word = false,
            accept_line = false,
            next = "<M-]>",
            prev = "<M-[>",
            dismiss = "<C-]>",
          },
        },
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
      { mode = { "n", "v" }, "<leader>cc", ":CopilotChatToggle<cr>",   desc = "Toggle Copilot Chat" },
      { mode = { "v" },      "<leader>ce", ":CopilotChatExplain<cr>",  desc = "Explain code" },
      { mode = { "n", "v" }, "<leader>cr", ":CopilotChatReview<cr>",   desc = "Code review" },
      { mode = { "v" },      "<leader>co", ":CopilotChatOptimize<cr>", desc = "Optimise code" },
      { mode = { "n", "v" }, "<leader>ct", ":CopilotChatTests<cr>",    desc = "Generate tests" },
    },
    opts = {
      highlight_selection = true,
      auto_insert_mode = false,
      chat_autocomplete = true,
      sticky = {
        '#files:full',
        '@copilot',
      },
      window = {
        layout = 'vertical', -- 'vertical' | 'horizontal'
        width = 0.5,         -- fractional width of parent, or absolute width in columns when > 1
      },
      headers = {
        user = '🤔 User', -- Header to use for user questions
        assistant = '🤖 Copilot', -- Header to use for AI answers
        tool = '🛠️ Tool', -- Header to use for tool calls
      },
      mappings = {
        show_diff = {
          normal = 'gd',
          full_diff = true, -- Show full diff instead of unified diff when showing diff window
        },
        accept_diff = {
          normal = 'ga',
          insert = 'ga',
        },
        reset = {
          normal = 'gr',
          insert = 'gr',
        },
      },
      prompts = {
        Rename = {
          prompt = 'Please rename the variable correctly in given selection based on context',
          system_prompt =
            "You are an expert in software development, and follow best practice for design patterns and architectures",
          mapping = '<leader>ad',
          description = 'Default prompt',
          selection = function(source)
            local select = require('CopilotChat.select')
            return select.visual(source)
          end
        },
        NiceInstructions = {
          prompt = 'Explain how it works.',
          system_prompt = 'You are a nice coding tutor, so please respond in a friendly and helpful manner.',
          description = 'My custom prompt description',
        }
      }
    },
    config = function(_, opts)
      require("CopilotChat").setup(opts)
    end
  }
}
