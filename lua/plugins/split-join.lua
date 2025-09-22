return {
    {
        'echasnovski/mini.splitjoin',
        keys = {
            {
                'gS',
                function()
                    require('mini.splitjoin').toggle()
                end,
                desc = 'Join/split code block',
            },
        },
        opts = {
            mappings = {
                toggle = 'gS',
            },
        },
    },
}
