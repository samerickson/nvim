return {
  "lewis6991/gitsigns.nvim",
  event = "VeryLazy",
  config = function()
    require("gitsigns").setup {
      _signs_staged_enable = true,
    }
  end
}
