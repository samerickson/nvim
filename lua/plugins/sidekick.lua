---@module 'lazy'
---@type LazySpec
return {
    'folke/sidekick.nvim',
    opts = {
        -- add any options here
        cli = {
            mux = {
                backend = 'tmux',
                enabled = not require('samerickson.utils').is_windows,
            },
        },
    },
    keys = {
        {
            '<leader>as',
            function()
                require('sidekick.cli').select()
            end,
            desc = 'Sidekick Select CLI',
        },
        {
            '<leader>ad',
            function()
                require('sidekick.cli').close()
            end,
            desc = 'Sidekick Close',
        },
        {
            '<leader>af',
            function()
                require('sidekick.cli').send { msg = '{file}' }
            end,
            desc = 'Send File',
        },
        {
            '<leader>av',
            function()
                require('sidekick.cli').send { msg = '{selection}' }
            end,
            mode = { 'v' },
            desc = 'Sidekick Send Visual Selection',
        },
        {
            '<leader>ap',
            function()
                require('sidekick.cli').prompt()
            end,
            mode = { 'n', 'v' },
            desc = 'Sidekick Select Prompt',
        },
        {
            '<a-/>',
            function()
                require('sidekick.cli').toggle { name = 'codex', focus = true }
            end,
            mode = { 'n', 'x', 'i', 't' },
            desc = 'Sidekick Switch Toggle',
        },
        {
            '<a-.>',
            function()
                require('sidekick.cli').focus { name = 'codex', focus = true }
            end,
            mode = { 'n', 'x', 'i', 't' },
            desc = 'Sidekick Switch Focus',
        },
    },
}
