local personal_obsidian_path = os.getenv("OBSIDIAN_PERSONAL")

if personal_obsidian_path == nil then
  return {}
end

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
