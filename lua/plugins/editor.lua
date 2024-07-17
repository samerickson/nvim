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
      spec = {
        { "<leader>gd", group = "diff", icon = { icon = "󰦓", color = "green" } },
        { "<leader>n", group = "notes", icon = { icon = "", color = "green" } },
        { "<leader>r", group = "refactoring", icon = { icon = "", color = "red" } },
      },
    },
  },
  {
    "stevearc/oil.nvim",
    opts = {},
    cmd = {
      "Oil",
    },
    keys = {
      { "<leader>o", "<cmd>Oil --float<cr>", desc = "Open Oil" },
      { "-", "<cmd>Oil<cr>", desc = "Open Oil" },
    },
  },
}
