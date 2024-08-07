return {
  "mfussenegger/nvim-dap",  -- Debugger Adapter: The adapter to bridge the communication between every debugger and neovim
  dependencies = {
    "rcarriga/nvim-dap-ui", -- UI for dap
    "nvim-neotest/nvim-nio",
    "leoluz/nvim-dap-go",
    "mxsdev/nvim-dap-vscode-js",
  },
  config = function()
    local dap, dapui = require("dap"), require("dapui")

    require("dapui").setup()
    require("dap-go").setup()
    -- Instruction: https://miguelcrespo.co/posts/debugging-javascript-applications-with-neovim/
    require("dap-vscode-js").setup({
      -- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
      debugger_path = vim.env.HOME .. "/Projects/vscode-js-debug",
      -- debugger_cmd = { "extension" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
      adapters = {
        "chrome",
        "pwa-node",
        "pwa-chrome",
        "pwa-msedge",
        "node-terminal",
        "pwa-extensionHost",
        "node",
        "chrome",
      }, -- which adapters to register in nvim-dap
      -- log_file_path = "(stdpath cache)/dap_vscode_js.log" -- Path for file logging
      -- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
      -- log_console_level = vim.log.levels.ERROR -- Logging level for output to console. Set to false to disable console output.
    })

    local js_based_languages = { "typescript", "javascript", "typescriptreact" }

    for _, language in ipairs(js_based_languages) do
      require("dap").configurations[language] = {
        -- for single NodeJS files
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          cwd = "${workspaceFolder}",
        },
        -- for Express apps
        {
          type = "pwa-node",
          request = "attach",
          name = "Attach",
          processId = require("dap.utils").pick_process,
          cwd = "${workspaceFolder}",
        },
        -- For web apps
        {
          type = "pwa-chrome",
          request = "launch",
          name = 'Start Chrome with "localhost"',
          url = "http://localhost:3000/#/au/",
          webRoot = "${workspaceFolder}",
          userDataDir = "${workspaceFolder}/.vscode/vscode-chrome-debug-userdatadir",
        },
      }
    end

    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end

    vim.keymap.set("n", "<Leader>dc", dap.continue, {})
    vim.keymap.set("n", "<Leader>dv", dap.step_over, {})
    vim.keymap.set("n", "<Leader>di", dap.step_into, {})
    vim.keymap.set("n", "<Leader>do", dap.step_out, {})
    vim.keymap.set("n", "<Leader>db", dap.toggle_breakpoint, {})
    vim.keymap.set("n", "<Leader>dB", function()
      require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
    end, { desc = "conditional breakpoint" })
    vim.keymap.set("n", "<leader>dt", dap.terminate, { desc = "Terminate" })
  end,
}
