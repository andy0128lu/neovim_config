return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-live-grep-args.nvim",
        -- This will not install any breaking changes.
        -- For major updates, this must be adjusted manually.
        version = "^1.0.0",
      },
    },
    opts = function(_, opts)
      local lga_actions = require("telescope-live-grep-args.actions")
      local actions = require("telescope.actions")

      local focus_preview = function(prompt_bufnr)
        local action_state = require("telescope.actions.state")
        local picker = action_state.get_current_picker(prompt_bufnr)
        local prompt_win = picker.prompt_win
        local previewer = picker.previewer
        local winid = previewer.state.winid
        local bufnr = previewer.state.bufnr
        vim.keymap.set("n", "<Tab>", function()
          vim.cmd(string.format("noautocmd lua vim.api.nvim_set_current_win(%s)", prompt_win))
        end, { buffer = bufnr })
        vim.cmd(string.format("noautocmd lua vim.api.nvim_set_current_win(%s)", winid))
        -- api.nvim_set_current_win(winid)
      end

      opts.extensions = {
        live_grep_args = {
          auto_quoting = true,
          mappings = { -- extend mappings
            i = {
              ["<C-k>"] = lga_actions.quote_prompt(),
              ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
              ["<C-s>"] = lga_actions.quote_prompt({ postfix = " --smart-case " }),
              ["<Tab>"] = focus_preview,
              -- TODO: doesn't work
              --["<C-l>"] = actions.results_scrolling_right, -- Scroll to left in results/preview
              --["<C-h>"] = actions.results_scrolling_left, -- Scroll to right in results/preview
            },
            n = {
              ["<Tab>"] = focus_preview,
              -- TODO: live_grep on the first live_grep result but doesn't seem working?
              ["<C-r>"] = {
                function(p_bufnr)
                  -- send results to quick fix list
                  require("telescope.actions").send_to_qflist(p_bufnr)
                  local qflist = vim.fn.getqflist()
                  local paths = {}
                  local hash = {}
                  for k in pairs(qflist) do
                    local path = vim.fn.bufname(qflist[k]["bufnr"]) -- extract path from quick fix list
                    if not hash[path] then                          -- add to paths table, if not already appeared
                      paths[#paths + 1] = path
                      hash[path] = true                             -- remember existing paths
                    end
                  end
                  -- show search scope with message
                  vim.notify("find in ...\n  " .. table.concat(paths, "\n  "))
                  -- execute live_grep_args with search scope
                  require("telescope").extensions.live_grep_args.live_grep_args({
                    search_dirs = paths,
                  })
                end,
                type = "action",
                opts = {
                  nowait = true,
                  silent = true,
                  desc = "Live grep on results",
                },
              },
            },
          },
        },
      }
      return opts
    end,
    config = function(_, opts)
      local telescope = require("telescope")
      local builtin = require("telescope.builtin")
      telescope.setup(opts)
      telescope.load_extension("live_grep_args")

      local function grep_cword()
        local live_grep_args_shortcuts = require("telescope-live-grep-args.shortcuts")
        return live_grep_args_shortcuts.grep_word_under_cursor()
      end

      local function live_grep_args()
        local lga = telescope.extensions.live_grep_args
        return lga.live_grep_args()
      end

      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "find files based on keyword" })
      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Search in the current buffer" })
      vim.keymap.set("n", "<leader>fl", builtin.resume, { desc = "Resume the last picker" })
      vim.keymap.set("n", "<leader>fg", live_grep_args, { desc = "Search in the current entire directory" })
      vim.keymap.set("n", "<leader>fc", grep_cword, { desc = "Search in the current buffer" })
      vim.keymap.set("n", "<leader>fs", builtin.treesitter, { desc = "Lists Function names, variables from Treesitter" })
    end,
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    config = function()
      local telescope = require("telescope")
      telescope.setup({
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
      telescope.load_extension("ui-select")
    end,
  },
}
