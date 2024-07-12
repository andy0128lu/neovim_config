return {
  "LintaoAmons/bookmarks.nvim",
  tag = "v0.5.3", -- optional, pin the plugin at specific version for stability
  dependencies = {
    { "nvim-telescope/telescope.nvim" },
    { "stevearc/dressing.nvim" } -- optional: to have the same UI shown in the GIF
  },
  keys = {
    { mode = { "n", "v" }, "<leader>mm", "<cmd>BookmarksMark<cr>",       desc = "Mark current line into active BookmarkList." },
    { mode = { "n", "v" }, "<leader>ml", "<cmd>BookmarksGoto<cr>",       desc = "Go to bookmark at current active BookmarkList" },
    { mode = { "n", "v" }, "<leader>ma", "<cmd>BookmarksCommands<cr>",   desc = "Find and trigger a bookmark command.([m]ark [a]ll)" },
    { mode = { "n", "v" }, "<leader>mp", "<cmd>BookmarksGotoRecent<cr>", desc = "Go to latest visited/created Bookmark ([m]ark [p]revious" }
  }
}
