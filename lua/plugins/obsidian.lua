return {
  "epwalsh/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  event = "VeryLazy",
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",

    -- Optional.
    "hrsh7th/nvim-cmp",
  },
  opts = {
    workspaces = {
      {
        name = "personal",
        path = "C:/Dev/test/quartz/content",
      },
    },

    -- see below for full list of options 👇
  },
}
