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
        opts = function(_, opts)
            local splitjoin = require 'mini.splitjoin'
            local gen_hook = splitjoin.gen_hook
            local all_brackets = { brackets = { '%b()', '%b[]', '%b{}' } }
            local curly_brackets = { brackets = { '%b{}' } }

            opts = opts or {}
            opts.mappings = opts.mappings or {}
            opts.mappings.toggle = 'gS'

            local add_comma = gen_hook.add_trailing_separator(all_brackets)
            local del_comma = gen_hook.del_trailing_separator(all_brackets)
            local pad_curly = gen_hook.pad_brackets(curly_brackets)

            opts.split = opts.split or {}
            opts.split.hooks_post = opts.split.hooks_post or {}
            table.insert(opts.split.hooks_post, add_comma)

            opts.join = opts.join or {}
            opts.join.hooks_post = opts.join.hooks_post or {}
            table.insert(opts.join.hooks_post, del_comma)
            table.insert(opts.join.hooks_post, pad_curly)

            return opts
        end,
    },
}
