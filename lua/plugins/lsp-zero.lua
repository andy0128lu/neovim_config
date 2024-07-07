return {
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v3.x",
    lazy = true,
    config = false,
    init = function()
      -- Disable automatic setup, we are doing it manually
      vim.g.lsp_zero_extend_cmp = 0
      vim.g.lsp_zero_extend_lspconfig = 0
    end,
  },
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = true,
  },

  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      { "L3MON4D3/LuaSnip" },
    },
    config = function()
      -- Here is where you configure the autocompletion settings.
      local lsp_zero = require("lsp-zero")
      lsp_zero.extend_cmp()

      -- And you can configure cmp even more, if you want to.
      local cmp = require("cmp")
      local cmp_action = lsp_zero.cmp_action()

      cmp.setup({
        formatting = lsp_zero.cmp_format({ details = true }),
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-u>"] = cmp.mapping.scroll_docs(-4),
          ["<C-d>"] = cmp.mapping.scroll_docs(4),
          ["<C-f>"] = cmp_action.luasnip_jump_forward(),
          ["<C-b>"] = cmp_action.luasnip_jump_backward(),
        }),
      })
    end,
  },

  -- LSP
  {
    "neovim/nvim-lspconfig",
    cmd = { "LspInfo", "LspInstall", "LspStart" },
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "hrsh7th/cmp-nvim-lsp" },
      { "williamboman/mason-lspconfig.nvim" },
      { "Hoffs/omnisharp-extended-lsp.nvim" },
    },
    config = function()
      -- This is where all the LSP shenanigans will live
      local lsp_zero = require("lsp-zero")
      lsp_zero.extend_lspconfig()

      -- -- Setting up for omnisharp extension
      -- lsp.configure("omnisharp", {
      --   handlers = {
      --     ["textDocument/definition"] = require("omnisharp_extended").handler,
      --     ["textDocument/typeDefinition"] = require("omnisharp_extended").type_definition_handler,
      --     ["textDocument/references"] = require("omnisharp_extended").references_handler,
      --     ["textDocument/implementation"] = require("omnisharp_extended").implementation_handler,
      --   },
      -- })
      -- require'lspconfig'.omnisharp.setup(config)

      --- if you want to know more about lsp-zero and mason.nvim
      --- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md
      lsp_zero.on_attach(function(client, bufnr)
        -- see :help lsp-zero-keybindings
        -- to learn the available actions
        lsp_zero.default_keymaps({ buffer = bufnr })
      end)

      require("mason-lspconfig").setup({
        ensure_installed = { "eslint" },
        automatic_installation = true,
        handlers = {
          lsp_zero.default_setup,
        },
      })

      ---- Setup for Omnisharp for C#
      --require("lspconfig").omnisharp.setup({
      --  cmd = { "dotnet", "/Users/Andy.Lu/Downloads/omnisharp-linux-arm64-net6.0" },
      --  handlers = {
      --    ["textDocument/definition"] = require("omnisharp_extended").handler,
      --    ["textDocument/typeDefinition"] = require("omnisharp_extended").type_definition_handler,
      --    ["textDocument/references"] = require("omnisharp_extended").references_handler,
      --    ["textDocument/implementation"] = require("omnisharp_extended").implementation_handler,
      --  },
      --  settings = {
      --    FormattingOptions = {
      --      -- Enables support for reading code style, naming convention and analyzer
      --      -- settings from .editorconfig.
      --      EnableEditorConfigSupport = true,
      --      -- Specifies whether 'using' directives should be grouped and sorted during
      --      -- document formatting.
      --      OrganizeImports = nil,
      --    },
      --    MsBuild = {
      --      -- If true, MSBuild project system will only load projects for files that
      --      -- were opened in the editor. This setting is useful for big C# codebases
      --      -- and allows for faster initialization of code navigation features only
      --      -- for projects that are relevant to code that is being edited. With this
      --      -- setting enabled OmniSharp may load fewer projects and may thus display
      --      -- incomplete reference lists for symbols.
      --      LoadProjectsOnDemand = nil,
      --    },
      --    RoslynExtensionsOptions = {
      --      -- Enables support for roslyn analyzers, code fixes and rulesets.
      --      EnableAnalyzersSupport = nil,
      --      -- Enables support for showing unimported types and unimported extension
      --      -- methods in completion lists. When committed, the appropriate using
      --      -- directive will be added at the top of the current file. This option can
      --      -- have a negative impact on initial completion responsiveness,
      --      -- particularly for the first few completion sessions after opening a
      --      -- solution.
      --      EnableImportCompletion = nil,
      --      -- Only run analyzers against open files when 'enableRoslynAnalyzers' is
      --      -- true
      --      AnalyzeOpenDocumentsOnly = nil,
      --    },
      --    Sdk = {
      --      -- Specifies whether to include preview versions of the .NET SDK when
      --      -- determining which version to use for project loading.
      --      IncludePrereleases = true,
      --    },
      --  },
      --})
    end,
  },
}
