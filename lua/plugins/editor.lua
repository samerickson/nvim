local snippetsDir = vim.fn.stdpath("config") .. "/snippets"

return {
  {
    "chrisgrieser/nvim-scissors",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "garymjr/nvim-snippets",
      {
        "rafamadriz/friendly-snippets",
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load({
            paths = { snippetsDir },
          })
        end,
      },
    },
    opts = {
      snippetDir = snippetsDir,
    },
    cmd = {
      "ScissorsAddNewSnippet",
      "ScissorsCreateSnippetsForSnipperVars",
      "ScissorsEditSnippet",
    },
    keys = {
      {
        "<leader>Se",
        function()
          require("scissors").editSnippet()
        end,
        desc = "Snippet edit",
      },
      {
        "<leader>Sa",
        function()
          require("scissors").addNewSnippet()
        end,
        mode = { "n", "x" },
        desc = "Add new snippet",
      },
    },
  },
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
    "nvim-telescope/telescope.nvim",
    keys = {
      {
        "<leader>sB",
        "<cmd>Telescope git_branches<cr>",
        desc = "Git branches",
      },
    },
  },
  {
    "ruifm/gitlinker.nvim",
    requires = "nvim-lua/plenary.nvim",
    opts = {
      mapping = nil,
    },
    keys = {
      {
        "<leader>gy",
        function()
          require("gitlinker.actions").copy_to_clipboard()
        end,
        mode = { "n", "x" },
        desc = "Copy link to file location",
      },
      {
        "<leader>gY",
        function()
          require("gitlinker").get_buf_range_url("n", { action_callback = vim.ui.open })
        end,
        mode = { "n" },
        desc = "Open file in remote",
      },
      {
        "<leader>gY",
        function()
          require("gitlinker").get_buf_range_url("v", { action_callback = vim.ui.open })
        end,
        mode = { "x" },
        desc = "Open file in remote",
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
    "saghen/blink.cmp",
    opts = {
      keymap = {
        preset = "super-tab",
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
    "theprimeagen/refactoring.nvim",
    keys = {
      {
        "<leader>rr",
        function()
          require("telescope").extensions.refactoring.refactors()
        end,
        mode = { "n", "x" },
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
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },
  {
    "https://github.com/samerickson/markdown-title-fetch.nvim",
    opts = {},
    cmd = "MarkdownLinkPaste",
    keys = {
      { "<c-v>", "<cmd>MarkdownLinkPaste<cr>" },
    },
  },
  {
    "Wansmer/treesj",
    dependencies = { "nvim-treesitter/nvim-treesitter" }, -- if you install parsers with `nvim-treesitter`
    config = function()
      require("treesj").setup({
        use_default_keymaps = false,
      })
    end,
    keys = {
      { "gS", "<cmd>TSJToggle<cr>", desc = "Toggle parameter split/join" },
    },
  },
}
