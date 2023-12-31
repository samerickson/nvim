return {
  "danymat/neogen",
  dependencies = "nvim-treesitter/nvim-treesitter",
  config = true,
  event = "VeryLazy",
  init = function()
    local wk = require("which-key")

    wk.register({
      ["<leader>d"] = {
        name = "📃 Documentation",
        g = "🧬 Generate documentation"
      }
    })

    vim.api.nvim_set_keymap("n", "<leader>dg", ":lua require('neogen').generate()<cr>", { noremap = true, silent = true })
  end
}
