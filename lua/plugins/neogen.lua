return {
    {
        'danymat/neogen',
        config = true,
        event = 'VeryLazy',
        keys = {
            {
                '<c-p>',
                mode = 'i',
                function()
                    require('neogen').jump_prev()
                end,
                desc = 'Neogen jump to previous mark',
            },
            {
                '<c-n>',
                mode = 'i',
                function()
                    require('neogen').jump_next()
                end,
                desc = 'Neogen jump to next mark',
            },
        },
    },
}
