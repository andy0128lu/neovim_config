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
		lazy = false,
		opts = {
			automatic_installation = true,
		},
		config = function()
			require("mason-lspconfig").setup({
				automatic_installation = true,
			})
		end,
	},
	{
		"neovim/nvim-lspconfig", -- setup different LSP
		lazy = false,
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities() -- connect completion window to LSP servers
			local lspconfig = require("lspconfig")
			local lspservers = {
				"lua_ls",
				"bashls",
				"omnisharp",
				"cssls",
				"dockerls",
				"golangci_lint_ls",
				"html",
				"tsserver",
				"quick_lint_js",
				"jqls",
				"marksman",
				"rubocop",
				"sqlls",
				"biome",
				"yamlls",
			}

			for _, lsp in ipairs(lspservers) do
				lspconfig[lsp].setup({
					capabilities = capabilities,
				})
			end

			vim.keymap.set("n", "K", vim.lsp.buf.hover, {}) -- set in Normal mode, press "K" to call hover function
			vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
			vim.keymap.set({ "n" }, "<leader>ca", vim.lsp.buf.code_action, {})
		end,
	},
}
