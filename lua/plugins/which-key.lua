return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {
    key_labels = {
      ["<leader>"] = "Leader",
      ["CR"] = "Ctrl",
      ["<C>"] = "ENTER"
    },
    triggers_blacklist = {
      i = { "j", "k" },
      v = { "j", "k" }
    }
  }
}
