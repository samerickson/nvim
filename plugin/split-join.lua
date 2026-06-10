vim.pack.add {
    { src = 'https://github.com/echasnovski/mini.splitjoin' },
}

local all_brackets = { brackets = { '%b()', '%b[]', '%b{}' } }
local curly_brackets = { brackets = { '%b{}' } }

local splitjoin = require 'mini.splitjoin'
local gen_hook = splitjoin.gen_hook
splitjoin.setup {
    mappings = {
        toggle = 'gS',
    },

    split = {
        hooks_post = {
            gen_hook.add_trailing_separator(all_brackets),
        },
    },

    join = {
        hooks_post = {
            gen_hook.del_trailing_separator(all_brackets),
            gen_hook.pad_brackets(curly_brackets),
        },
    },
}

vim.keymap.set('n', 'gS', function()
    splitjoin.toggle()
end, { desc = 'Join/split code block' })
