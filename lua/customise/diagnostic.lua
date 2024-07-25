-- Modify virtual text of diagnostic
local function get_formatted_diagnostic(diagnostic)
  local count = {}
  local levels = {
    errors = "Error",
    warnings = "Warn",
    info = "Info",
    hints = "Hint",
  }

  for k, level in pairs(levels) do
    count[k] = vim.tbl_count(vim.diagnostic.get(0, { severity = level, scope = "line" }))
  end
  local errors = ""
  local warnings = ""
  local hints = ""
  local info = ""
  if count["errors"] ~= 0 then
   --errors = " " .. vim.fn.sign_getdefined("DiagnosticsSignError") .. " " .. count["errors"]
    errors = " " .. " " .. count["errors"]
  end
  if count["warnings"] ~= 0 then
    --warnings = " " .. vim.fn.sign_getdefined("DiagnosticsSignWarn") .. " " .. count["warnings"]
    warnings = " " .. " " .. count["warnings"]
  end
  if count["hints"] ~= 0 then
    -- hints = " " .. vim.fn.sign_getdefined("DiagnosticsSignHint") .. " " .. count["hints"]
    hints = " " .. " " .. count["hints"]
  end
  if count["info"] ~= 0 then
    --    info = " " .. vim.fn.sign_getdefined("DiagnosticsSignInfo") .. "  " .. count["info"]
    info = " " .. " " .. count["info"]
  end

  return errors .. warnings .. hints .. info .. " " .. diagnostic.message
end

vim.diagnostic.config({
  virtual_text = {
    --prefix = "",
    scope = "line",
    severity = vim.diagnostic.severity.INFO -- show diagnostic which severity is higher than the value
    --format = get_formatted_diagnostic,
  },
  signs = true,
  float = {
    border = "single",
    severity_sort = true,
    scope = "line",
    format = function(diagnostic)
      return string.format(
        "%s (%s) [%s]",
        diagnostic.message,
        diagnostic.source,
        diagnostic.code or diagnostic.user_data.lsp.code
      )
    end,
  },
})

-- Open diagnostic in a floating window
vim.keymap.set(
  "n",
  "<leader>i",
  ":lua vim.diagnostic.open_float(0, { focus=true, scope='line' })<CR>", -- 0: the current buffer
  { desc = "Show diagnostic in floating window" }
)

-- Kepmap to toggle diagnostic
local diagnostics_active = true

local toggle_diagnostics = function()
  diagnostics_active = not diagnostics_active
  if diagnostics_active then
    vim.diagnostic.show()
  else
    vim.diagnostic.hide()
  end
end
vim.keymap.set("n", "<leader>dt", toggle_diagnostics, { desc = "Toggle diagnostic" })
