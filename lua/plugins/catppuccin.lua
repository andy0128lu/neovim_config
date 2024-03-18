return {
  "catppuccin/nvim",
  lazy = false,
  name = "catppuccin",
  priority = 1000,
  opts = { flavour = "mocha" }, -- latte, frappe, macchiato, mocha
  config = function()
    vim.cmd.colorscheme("catppuccin")
  end,
}
