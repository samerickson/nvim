return {
  "danymat/neogen",
  dependencies = "nvim-treesitter/nvim-treesitter",
  config = true,
  event = "VeryLazy",
  init = function()
    vim.api.nvim_set_keymap("n", "<leader>nf", ":lua require('neogen').generate()<cr>", { noremap = true, silent = true })
  end
}
