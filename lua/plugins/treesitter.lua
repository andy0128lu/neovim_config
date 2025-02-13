return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  commit = "49f1b9a",
  config = function()
    local treesitterConfig = require("nvim-treesitter.configs")
    treesitterConfig.setup({
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
      --update_focused_file = {
      --  enable = true
      --}
    })
  end,
}
