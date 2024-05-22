local personal_obsidian_path = os.getenv("OBSIDIAN_PERSONAL")

if personal_obsidian_path == nil then
  return {}
end

return {
  "epwalsh/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",

    -- Optional.
    "hrsh7th/nvim-cmp",
  },
  keys = {
    { "<leader>nd", "<cmd>ObsidianDailies<cr>", desc = "Daily notes" },
    { "<leader>no", "<cmd>ObsidianOpen<cr>", desc = "Open Obsidian" },
    { "<leader>nn", "<cmd>ObsidianNew<cr>", desc = "New note" },
    { "<leader>ns", "<cmd>ObsidianSearch<cr>", desc = "Grep search notes" },
    { "<leader>ns", "<cmd>ObsidianQuickSwitch<cr>", desc = "Find note" },
  },
  cmd = {
    "ObsidianNew",
    "ObsidianCheck",
    "ObsidianDailies",
    "ObsidianOpen",
    "ObsidianQuickSwitch",
    "ObsidianPasteImg",
    "ObsidianSearch",
    "ObsidianWorkspace",
  },
  opts = {
    workspaces = {
      {
        name = "personal",
        path = personal_obsidian_path,
      },
    },
    daily_notes = {
      -- Optional, if you keep daily notes in a separate directory.
      folder = "dailies",
      -- Optional, if you want to change the date format for the ID of daily notes.
      date_format = "%Y-%m-%d",
      -- Optional, if you want to change the date format of the default alias of daily notes.
      alias_format = "%Y-%m-%d",
      -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
      template = nil,
    },
    completion = {
      -- Set to false to disable completion.
      nvim_cmp = true,
      -- Trigger completion at 2 chars.
      min_chars = 2,
    },
    new_notes_location = "notes",
    preferred_link_style = "markdown",
  },
}
