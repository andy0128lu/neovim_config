return {
	"nvimtools/none-ls.nvim",
	-- wrap all CLI tools of linter and formatter, eg: eslint, prettier, rubocop,
	-- and communicate with neovim lsp client
	config = function()
		local null_ls = require("null-ls")

		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				-- rubocop threw errors and didn't work. It may need to wait for patches in new versions
				-- null_ls.builtins.diagnostics.rubocop,
				-- null_ls.builtins.formatting.rubocop,
				null_ls.builtins.diagnostics.eslint_d,
				null_ls.builtins.formatting.eslint_d,
				null_ls.builtins.formatting.prettier,
				null_ls.builtins.completion.spell,
			},
		})

		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
	end,
}
