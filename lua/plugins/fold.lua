return {
  "kevinhwang91/nvim-ufo",
  dependencies = { "kevinhwang91/promise-async" },
  opts = {
    close_fold_kinds_for_ft = {
      -- default = {'imports', 'comment'} -- TODO: Tweak it. It's disabled for now as sometimes collapse more than I wanted
    },
    fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
      -- global handler
      -- customise collapse text
      -- `handler` is the 2nd parameter of `setFoldVirtTextHandler`,
      -- check out `./lua/ufo.lua` and search `setFoldVirtTextHandler` for detail.
      local newVirtText = {}
      local suffix = (" 󰁂 %d "):format(endLnum - lnum)
      local sufWidth = vim.fn.strdisplaywidth(suffix)
      local targetWidth = width - sufWidth
      local curWidth = 0
      for _, chunk in ipairs(virtText) do
        local chunkText = chunk[1]
        local chunkWidth = vim.fn.strdisplaywidth(chunkText)
        if targetWidth > curWidth + chunkWidth then
          table.insert(newVirtText, chunk)
        else
          chunkText = truncate(chunkText, targetWidth - curWidth)
          local hlGroup = chunk[2]
          table.insert(newVirtText, { chunkText, hlGroup })
          chunkWidth = vim.fn.strdisplaywidth(chunkText)
          -- str width returned from truncate() may less than 2nd argument, need padding
          if curWidth + chunkWidth < targetWidth then
            suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
          end
          break
        end
        curWidth = curWidth + chunkWidth
      end
      table.insert(newVirtText, { suffix, "MoreMsg" })
      return newVirtText
    end,
  },
  config = function(_, opts)
    vim.o.foldcolumn = "0"      -- '0' is not bad
    vim.o.foldlevel = 99        -- Minimum level of a fold that will be closed by default
    vim.o.foldlevelstart = 99   -- any nested will be closed by default
    vim.opt.foldmethod = "expr" -- Using treesitter for folding
    vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    vim.o.foldenable = true

    local ufo = require("ufo")
    ufo.setup(opts)

    vim.keymap.set("n", "zR", ufo.openAllFolds, { desc = "Open all folds" })
    vim.keymap.set("n", "zM", ufo.closeAllFolds, { desc = "Close all folds" })
    -- TODO: set it in opts close_fold_kinds_for_ft (imports), but didn't seem working
    vim.keymap.set('n', 'zr', ufo.openFoldsExceptKinds, { desc = "Expand folds to certain level" })
    vim.keymap.set('n', 'zm', function() ufo.closeFoldsWith(2) end, { desc = "Collpase folds to certain level" }) -- closeAllFolds == closeFoldsWith(0)
    vim.keymap.set("n", "K", function()
      local winid = ufo.peekFoldedLinesUnderCursor(true)
      if not winid then
        vim.lsp.buf.hover()
      end
    end, { desc = "LSP: Show hover documentation and folded code" })
  end,
}
