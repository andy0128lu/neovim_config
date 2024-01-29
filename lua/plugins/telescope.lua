return  {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.5', 
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function() 
    local builtin = require("telescope.builtin")
    vim.keymap.set('n', '<leader>ff', builtin.find_files, {}) -- Set shortcut "space + ff" to find files based on keyword
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, {}) -- Set shortcut "space + fg" to grap files through projects
  end
}

