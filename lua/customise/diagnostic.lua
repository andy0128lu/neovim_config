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
    count[k] = vim.tbl_count(vim.diagnostic.get(0, { severity = level, lnum = diagnostic.lnum }))
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
  virtual_lines = false,
  virtual_text = false,
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
vim.keymap.set("n", "<leader>dx", function()
  local current = vim.diagnostic.config().virtual_text
  local is_shown = current and true or false

  local new_config
  if is_shown then
    new_config = { virtual_text = false }
  else
    new_config = {
      virtual_text = {
        scope = "line", -- show one virtual text per line instead of per diagnostic. Not necessary if it call a custom formatter below
        prefix = "",  -- remove the default ■ symbol
        severity = { min = vim.diagnostic.severity.WARN },
        format = get_formatted_diagnostic
      }
    }
  end
  vim.diagnostic.config(vim.tbl_extend("force", vim.diagnostic.config(), new_config))
  print("Virtual text: " .. (is_shown and "Enabled" or "Disabled"))
end, { desc = "Toggle diagnostic virtual text" })

-- Keymap to toggle virtual line of diagnostic 
vim.keymap.set("n", "<leader>dv", function()
  local current = vim.diagnostic.config().virtual_lines
  local is_shown = current and true or false  -- ensure boolean

	if is_shown then
		new_config = { virtual_lines = false }
	else
    -- Only show virtual line diagnostics for the current cursor line
		new_config = { virtual_lines = { current_line = true } }
	end
  vim.diagnostic.config(vim.tbl_extend("force", vim.diagnostic.config(), new_config))
  print("Virtual line: " .. (is_shown and "Enabled" or "Disabled"))
end, { desc = "Toggle diagnostic virtual line" })

-- Kepmap to toggle diagnostic
local toggle_diagnostics = function()
  toggle = not vim.diagnostic.is_enabled()
  print("Diagnostic: " .. (toggle and "Enabled" or "Disabled"))
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end
vim.keymap.set("n", "<leader>dt", toggle_diagnostics, { desc = "Toggle diagnostic" })
