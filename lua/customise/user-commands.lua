local yaml_schema_enabled = true

vim.api.nvim_create_user_command("ToggleYamlSchema", function()
  yaml_schema_enabled = not yaml_schema_enabled

  -- Stop all running YAML language server clients
  for _, client in pairs(vim.lsp.get_clients()) do
    if client.name == "yamlls" then
      client.stop()
    end
  end

  -- Restart LSP with updated config
  require('lspconfig').yamlls.setup {
    settings = {
      yaml = {
        schemaStore = {
          -- You must disable built-in schemaStore support if you want to use
          -- this plugin and its advanced options like `ignore`.
          enable = false,
          -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
          url = "",
        },
        schemas = require('schemastore').yaml.schemas(),
      },
    },
  }

  -- Reload buffer to restart LSP
  vim.cmd("edit")
  print("YAML Schema Validation: " .. (yaml_schema_enabled and "Enabled" or "Disabled"))
end, {})
