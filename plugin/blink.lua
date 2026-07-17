local on_plugin_update = require('samerickson.pack').on_plugin_update

vim.pack.add {
    { src = 'https://github.com/saghen/blink.lib', setup = false },
    { src = 'https://github.com/saghen/blink.cmp' },
}

vim.api.nvim_create_autocmd('InsertEnter', {
    once = true,
    callback = function()
        require('blink.cmp').setup {
            appearance = {
                nerd_font_variant = 'mono',
            },
            keymap = {
                ['<CR>'] = { 'accept', 'fallback' },
                ['<C-\\>'] = { 'hide', 'fallback' },
                ['<C-n>'] = { 'select_next', 'show' },
                ['<Tab>'] = { 'select_next', 'snippet_forward', 'fallback' },
                ['<C-p>'] = { 'select_prev' },
                ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
                ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
            },
            sources = {
                default = { 'lsp', 'buffer' },
            },
            cmdline = { enabled = false },
            fuzzy = { implementation = 'prefer_rust_with_warning' },
            completion = {
                list = { selection = { preselect = false, auto_insert = false } },
                menu = {
                    auto_show = function(ctx)
                        return ctx.mode ~= 'cmdline'
                    end,
                    border = 'rounded',
                    winhighlight = 'Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None',
                    draw = {
                        treesitter = { 'lsp' },
                    },
                },
                accept = {
                    auto_brackets = { enabled = false },
                },
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 500,
                    window = {
                        border = 'rounded',
                        winhighlight = 'Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None',
                    },
                },
            },
        }
    end,
})

on_plugin_update('blink.cmp', function()
    ---@diagnostic disable-next-line: undefined-field
    require('blink.cmp').build():pwait(60000)
end)
