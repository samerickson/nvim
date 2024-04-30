return {
  {
    "sindrets/diffview.nvim",
    event = "LazyFile",
    keys = {
      {
        "<leader>gdo",
        "<cmd>DiffviewOpen<cr>",
        desc = "Open diff view",
      },
      {
        "<leader>gdc",
        "<cmd>DiffviewClose<cr>",
        desc = "Close diff view",
      },
      {
        "<leader>gdh",
        "<cmd>DiffviewFileHistory<cr>",
        desc = "Show file history",
      },
    },
  },
  {
    "which-key.nvim",
    opts = {
      defaults = {
        ["<leader>gd"] = { name = "Diff" },
      },
    },
  },
}
