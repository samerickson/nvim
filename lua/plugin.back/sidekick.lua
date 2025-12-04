return {
    'folke/sidekick.nvim',
    opts = {
        -- add any options here
        cli = {
            mux = {
                backend = 'tmux',
                enabled = true,
            },
        },
    },
    keys = {
        {
            '<tab>',
            function()
                -- if there is a next edit, jump to it, otherwise apply it if any
                if not require('sidekick').nes_jump_or_apply() then
                    return '<Tab>' -- fallback to normal tab
                end
            end,
            expr = true,
            desc = 'Goto/Apply Next Edit Suggestion',
        },
        {
            '<leader>as',
            function()
                require('sidekick.cli').select()
            end,
            desc = 'Sidekick Select CLI',
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
                require('sidekick.cli').toggle()
            end,
            mode = { 'n', 'x', 'i', 't' },
            desc = 'Sidekick Switch Focus',
        },
    },
}
