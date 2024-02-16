return {
  "mfussenegger/nvim-dap", -- Debugger Adapter: The adapter to bridge the communication between every debugger and neovim
  dependencies = {
    "rcarriga/nvim-dap-ui", -- UI for dap
    "leoluz/nvim-dap-go",
  },
  config = function()
    local dap, dapui = require("dap"), require("dapui")

    require("dapui").setup()
    require("dap-go").setup()

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

    vim.keymap.set("n", "<Leader>dt", dap.toggle_breakpoint, {})
    vim.keymap.set("n", "<Leader>dc", dap.continue, {})
    vim.keymap.set("n", "<Leader>dv", dap.step_over, {})
    vim.keymap.set("n", "<Leader>di", dap.step_into, {})
    vim.keymap.set("n", "<Leader>do", dap.step_out, {})
  end,
}
