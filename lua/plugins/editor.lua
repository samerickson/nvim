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
    "mfussenegger/nvim-dap",
    -- stylua: ignore
    keys = {
      { "<F9>", function() require("dap").step_into() end, desc = "Step Into" },
      { "<S-F9>", function() require("dap").step_out() end, desc = "Step Out" },
      { "<F10>", function() require("dap").step_over() end, desc = "Step Over" },
      { "<F5>", function() require("dap").continue() end, desc = "Run/Continue" }
    },
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "marilari88/neotest-vitest",
    },
    opts = {
      adapters = {
        ["neotest-vitest"] = {},
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
  {
    "https://github.com/samerickson/markdown-title-fetch.nvim",
    opts = {},
    cmd = "MarkdownLinkPaste",
  },
  {
    "echasnovski/mini.splitjoin",
    keys = {
      {
        "<leader>cj",
        function()
          require("mini.splitjoin").toggle()
        end,
        desc = "Join/split code block",
      },
    },
    opts = {
      mappings = {
        toggle = "<leader>cj",
      },
    },
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
    opts = {
      enable_moveright = false,
    },
  },
}
