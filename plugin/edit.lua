vim.pack.add {
    'https://github.com/NMAC427/guess-indent.nvim',
    'https://github.com/lewis6991/gitsigns.nvim',
}

require('guess-indent').setup {}
require('gitsigns').setup {
    -- signs = {
    --     add = { text = '+' }, ---@diagnostic disable-line: missing-fields
    --     change = { text = '~' }, ---@diagnostic disable-line: missing-fields
    --     delete = { text = '_' }, ---@diagnostic disable-line: missing-fields
    --     topdelete = { text = '‾' }, ---@diagnostic disable-line: missing-fields
    --     changedelete = { text = '~' }, ---@diagnostic disable-line: missing-fields
    -- },
    signs = {
        add = { text = '▎' },
        change = { text = '▎' },
        delete = { text = '' },
        topdelete = { text = '' },
        changedelete = { text = '▎' },
        untracked = { text = '▎' },
    },
    signs_staged = {
        add = { text = '▎' },
        change = { text = '▎' },
        delete = { text = '' },
        topdelete = { text = '' },
        changedelete = { text = '▎' },
    },
}
