return {
    {
        "ibhagwan/fzf-lua",
        -- optional for icon support
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            fzf_colors = {
                bg = { 'bg', 'Normal' },
                gutter = { 'bg', 'Normal' },
                info = { 'fg', 'Conditional' },
                scrollbar = { 'bg', 'Normal' },
                separator = { 'fg', 'Comment' },
            }
        },
        keys = {
            { '<leader>ff', '<cmd>FzfLua files<cr>', desc = 'Find files' },
            { '<leader><space>', '<cmd>FzfLua files<cr>', desc = 'Find files' },
            { '<leader>fg', '<cmd>FzfLua live_grep_glob<cr>', desc = 'Grep' },
            { '<leader>/', '<cmd>FzfLua live_grep_glob<cr>', desc = 'Grep' },
        }
    }
}
