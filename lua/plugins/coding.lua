return {
  {
    "danymat/neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = true,
    keys = {
      { "gc", "<cmd>Neogen<cr>", desc = "Generate documentation" },
    },
  },
}
