return {
  "LintaoAmons/bookmarks.nvim",
  dependencies = {
    { "nvim-telescope/telescope.nvim" },
    { "stevearc/dressing.nvim" } -- optional: to have the same UI shown in the GIF
  },
  opts = {
    picker = {
      -- choose built-in sort logic by name: string, find all the sort logics in `bookmarks.adapter.sort-logic`
      -- or custom sort logic: function(bookmarks: Bookmarks.Bookmark[]): nil
      sort_by = "last_visited",
    },
    treeview = {
      bookmark_format = function(bookmark)
        return bookmark.name ..
        " [" .. bookmark.location.project_name .. "] " .. bookmark.location.relative_path .. " : " .. bookmark.content
      end,
      keymap = {
        quit = { "q", "<ESC>" },
        refresh = "R",
        create_folder = "a",
        tree_cut = "x",
        tree_paste = "p",
        collapse = "o",
        delete = "d",
        active = "s",
        copy = "c",
      },
    },
  },
  keys = {
    { mode = { "n", "v" }, "<leader>mm", "<cmd>BookmarksMark<cr>",        desc = "Mark current line into active BookmarkList." },
    { mode = { "n", "v" }, "<leader>ml", "<cmd>BookmarksGoto<cr>",        desc = "Go to bookmark at current active BookmarkList" },
    { mode = { "n", "v" }, "<leader>ma", "<cmd>BookmarksCommands<cr>",    desc = "Find and trigger a bookmark command.([m]ark [a]ll)" },
    { mode = { "n", "v" }, "<leader>mp", "<cmd>BookmarksGotoRecent<cr>",  desc = "Go to latest visited/created Bookmark ([m]ark [p]revious" },
    { mode = { "n", "v" }, "<leader>mt", "<cmd>BookmarksTree<cr>",        desc = "Open tree view" }
  },
  config = function(_, opts)
    require("bookmarks").setup(opts);
  end
}
