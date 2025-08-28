return {
    'stevearc/oil.nvim',
    ---@module 'oil'
    opts = {},
    -- Optional dependencies
    dependencies = { { 'echasnovski/mini.icons', opts = {} } },
    event = 'VeryLazy',
    keys = {
        { '-', '<cmd>Oil<cr>', desc = 'Open parent directory' },
    },
}
