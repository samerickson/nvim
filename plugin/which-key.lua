vim.pack.add { 'https://github.com/folke/which-key.nvim' }

require('which-key').setup {
    -- preset = 'helix',
    delay = 0,
    icons = { mappings = true },
    spec = {
        {
            mode = { 'n', 'v' },
            { '<leader><tab>', group = 'tabs' },
            { '<leader>c', group = 'code' },
            { '<leader>d', group = 'debug' },
            { '<leader>dp', group = 'profiler' },
            { '<leader>f', group = 'find' },
            { '<leader>g', group = 'git' },
            { '<leader>gh', group = 'hunks' },
            { '<leader>q', group = 'quit' },
            { '<leader>s', group = 'search' },
            { '<leader>u', group = 'ui' },
            { '<leader>x', group = 'quickfix' },
            { '<leader>r', group = 'refactor' },
            { '<leader>n', group = 'notes' },
            { '[', group = 'prev' },
            { ']', group = 'next' },
            { 'g', group = 'goto' },
            { 'gs', group = 'surround' },
            { 'z', group = 'fold' },
            {
                '<leader>b',
                group = 'buffer',
                expand = function()
                    return require('which-key.extras').expand.buf()
                end,
            },
            {
                '<leader>w',
                group = 'windows',
                proxy = '<c-w>',
                expand = function()
                    return require('which-key.extras').expand.win()
                end,
            },
        },
    },
}
