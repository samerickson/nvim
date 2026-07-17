vim.pack.add {
    'https://github.com/nvim-mini/mini.files',
    'https://github.com/nvim-mini/mini.tabline',
    'https://github.com/nvim-mini/mini.icons',
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
