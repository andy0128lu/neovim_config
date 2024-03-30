return {
  "akinsho/bufferline.nvim", -- aesthetic tab name
  enabled = true,
  version = "*",
  dependencies = "nvim-tree/nvim-web-devicons",
  opts = {
    options = {
      mode = "tabs", -- set to "tabs" to only show tabpages instead
      indicator = {
        icon = "▎", -- this should be omitted if indicator style is not 'icon'
        style = "icon", -- "icon" | "underline" | "none",
      },
      diagnostics = "nvim_lsp",
      diagnostics_indicator = function(count, level, diagnostics_dict, context)
        local s = " "
        for e, n in pairs(diagnostics_dict) do
          local sym = e == "error" and " " or (e == "warning" and " " or "")
          s = s .. n .. sym
        end
        return s
      end,
    },
  },
  -- Fix bufferline when restoring a session
  --vim.api.nvim_create_autocmd("BufAdd", {
  --  callback = function()
  --    vim.schedule(function()
  --      pcall(nvim_bufferline)
  --    end)
  --  end,
  --}),
}
