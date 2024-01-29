return { 
  'nvim-treesitter/nvim-treesitter',
  build = ":TSUpdate",
  config = function()
    local treesitterConfig = require("nvim-treesitter.configs")
    treesitterConfig.setup({
      ensure_installed = { 
        "lua", 
        "javascript", 
        "typescript", 
        "ruby", 
        "bash", 
        "markdown", 
        "html", 
        "css", 
        "json", 
        "c_sharp", 
        "sql" 
      },
      highlight = { enable = true },
      indent = { enable = true }
    })
  end
}
