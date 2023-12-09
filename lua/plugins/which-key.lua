return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  config = function ()
    local wk = require("which-key")
    wk.register({
      ["<C-p>"] = "🔍 git Files",
      ["<A-p>"] = "🔍 quickfix",
      ["<C-t>"] = "🔍 find files",
      ["<C-f>"] = "🔍 find in current file",
      ["<A-f>"] = "🔍 live grep",
      ["<A-t>"] = "🏗️ vim options",
      ["C-b"] = "🔍 buffers",
      ["<leader>"] = {
        t = {
          name = " 🔭 Telescope",
          t = "🔭 telescope",
          o = "🔍 git files",
          O = "🔎 old files",
          q = "🔍 quickfix",
          T = "🔍 find file",
          f = "🔍 find in current file",
          s = "🔍 live grep",
          b = "🔍 search buffers",
          d = "🐡 dotfiles",
          n = "🐠 neovim configuration files",
          i = "⚠️  View diagnostics",
          v = {
            name = "🦙 vim configuration",
            o = "vim options",
            c = "vim commands"
          },
          g = {
            name = "git",
            f = "🔍 files",
            b = "🔍 branches",
            c = "🔍 commits",
            s = "🔍 stashes",
            i = "🔎 status"
          }
        }
      }
    })
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
