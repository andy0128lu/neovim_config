return {
  'nvim-lualine/lualine.nvim',
  enabled = true,
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    options = {
      theme = 'material'
    },
  },
  config = function(_, opts)
    require('lualine').setup(opts)
  end
}
