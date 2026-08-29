vim.pack.add {
    'https://github.com/nvim-mini/mini.files',
    'https://github.com/nvim-mini/mini.tabline',
    'https://github.com/echasnovski/mini.icons',
    'https://github.com/nvim-mini/mini.bufremove',
}

require('mini.icons').setup()
require('mini.tabline').setup()

require('mini.files').setup {
    mappings = {
        show_help = '?',
        -- go_in_plus = '<cr>',
        -- go_out_plus = '<tab>',
    },
}

vim.keymap.set('n', '<leader>e', function()
    MiniFiles.open()
end, { desc = 'Mini Files' })

vim.keymap.set('n', '<leader>bd', function()
    require('mini.bufremove').delete()
end, { desc = 'Mini Files' })
