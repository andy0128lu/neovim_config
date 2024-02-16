return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
	},
	config = function(Plugin, opts)
		--require("neo-tree").setup({
		-- Tried to enable opeing neotree window by default but it also changed other default behaviour
		-- filesystem = {
		--    filtered_items = {
		--      visible = true, -- when true, they will just be displayed differently than normal items
		--      hide_dotfiles = false,
		--      hide_gitignored = false,
		--    }
		--}
		--})
		vim.keymap.set("n", "<leader>n", ":Neotree filesystem reveal left<CR>")
	end,
}
