vim.pack.add({
    { src = "https://github.com/folke/snacks.nvim" }
})

require("snacks").setup({
    bigfile = { enabled = true },
    dashboard = { enabled = false },
    explorer = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    picker = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = false },
})

vim.keymap.set('n', '<leader>fa', function() Snacks.picker() end)
vim.keymap.set('n', '<leader>ff', function() Snacks.picker.files() end)
vim.keymap.set('n', '<leader>e', function() Snacks.explorer() end)

