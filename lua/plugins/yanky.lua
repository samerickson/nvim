---@module 'lazy'
---@type LazySpec
return {
    'gbprod/yanky.nvim',
    recommended = true,
    desc = 'Better Yank/Paste',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
        system_clipboard = {
            sync_with_ring = not vim.env.SSH_CONNECTION,
        },
        highlight = { timer = 150 },
    },
    keys = {
        {
            '<leader>p',
            function()
                Snacks.picker.yanky()
            end,
            mode = { 'n', 'x' },
            desc = 'Open Yank History',
        },
        -- stylua: ignore
        { "y", "<Plug>(YankyYank)", mode = { "n", "x" }, desc = "Yank Text" },
        { 'p', '<Plug>(YankyPutAfter)', mode = { 'n', 'x' }, desc = 'Put Text After Cursor' },
        { 'P', '<Plug>(YankyPutBefore)', mode = { 'n', 'x' }, desc = 'Put Text Before Cursor' },
        { '[y', '<Plug>(YankyCycleForward)', desc = 'Cycle Forward Through Yank History' },
        { ']y', '<Plug>(YankyCycleBackward)', desc = 'Cycle Backward Through Yank History' },
    },
}
