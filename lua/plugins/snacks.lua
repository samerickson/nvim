vim.pack.add({
    { src = "https://github.com/folke/snacks.nvim" }
})

require("snacks").setup({
  -- enable only what you want:
  notifier = { enabled = true },
  indent = { enabled = true },
  scroll = { enabled = true },
  picker = { enabled = true },

  -- you can disable things:
  cursor = { enabled = false },
})

vim.keymap.set('n', '<leader>fa', function() Snacks.picker() end)
vim.keymap.set('n', '<leader>ff', function() Snacks.picker.files() end)

