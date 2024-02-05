return {
  {
    "williamboman/mason.nvim", -- Language Server Protocol
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim", -- Bridging LSP to Neovim to show LSP results
    config = function()
      require("mason-lspconfig").setup({
        automatic_installation = true,
        ensure_installed = {
          "lua_ls",
          "bashls",
          "omnisharp", -- C#
          "cssls",
          "dockerls",
          "docker_compose_language_service",
          "elixirls",
          "golangci_lint_ls",
          "html",
          "tsserver",
          "quick_lint_js",
          "jqls",
          "marksman",
          "rubocop",
          "sqlls",
          "biome", -- Typescript
          "yamlls",
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig", -- setup different LSP
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities() -- connect completion window to LSP servers

      local lspconfig = require("lspconfig")
      lspconfig.lua_ls.setup({
        capabilities = capabilities
      })
      lspconfig.bashls.setup({})
      lspconfig.omnisharp.setup({})
      lspconfig.cssls.setup({})
      lspconfig.dockerls.setup({})
      lspconfig.docker_compose_language_service.setup({})
      lspconfig.elixirls.setup({})
      lspconfig.golangci_lint_ls.setup({})
      lspconfig.html.setup({})
      lspconfig.tsserver.setup({})
      lspconfig.quick_lint_js.setup({})
      lspconfig.jqls.setup({})
      lspconfig.marksman.setup({})
      lspconfig.rubocop.setup({})
      lspconfig.sqlls.setup({})
      lspconfig.biome.setup({})
      lspconfig.yamlls.setup({})
      vim.keymap.set("n", "K", vim.lsp.buf.hover, {}) -- set in Normal mode, press "K" to call hover function
      vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
      vim.keymap.set({ "n" }, "<leader>ca", vim.lsp.buf.code_action, {})
    end,
  },
}
