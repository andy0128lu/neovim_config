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
  virtual_lines = {
    -- Only show virtual line diagnostics for the current cursor line
    current_line = true,
  },
  virtual_text = {
    --prefix = "",
    scope = "line",
    severity = { min = vim.diagnostic.severity.WARN },
    --format = get_formatted_diagnostic,
  },
  --signs = {severity = {min = vim.diagnostic.severity.WARN}},
  underline = { severity = { min = vim.diagnostic.severity.WARN } },
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

-- Keymap to toggle virtual line of diagnostic 
vim.keymap.set("n", "<leader>dv", function()
	if vim.diagnostic.config().virtual_lines then
		vim.diagnostic.config({ virtual_lines = false })
	else
		vim.diagnostic.config({ virtual_lines = { current_line = true } })
	end
end, {})

-- TODO: is it duplicate as diagnostic hover?
---- Open diagnostic in a floating window
--vim.keymap.set(
--  "n",
--  "<leader>i",
--  ":lua vim.diagnostic.open_float(0, { focus=true, scope='line' })<CR>", -- 0: the current buffer
--  { desc = "Show diagnostic in floating window" }
--)

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
