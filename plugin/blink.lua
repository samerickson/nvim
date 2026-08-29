local on_plugin_update = require('samerickson.pack').on_plugin_update

vim.pack.add {
    { src = 'https://github.com/saghen/blink.lib', setup = false },
    { src = 'https://github.com/saghen/blink.cmp' },
    { src = 'https://github.com/folke/lazydev.nvim' },
}
vim.api.nvim_create_autocmd('FileType', {
    once = true,
    pattern = { 'lua' },
    callback = function()
        require('lazydev').setup {
            library = {
                -- See the configuration section for more details
                -- Load luvit types when the `vim.uv` word is found
                { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
            },
        }
    end,
})

-- Effectively disables blink for testing built in completion
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
                default = { 'lazydev', 'lsp', 'path', 'buffer' },
                providers = {
                    lazydev = {
                        name = 'LazyDev',
                        module = 'lazydev.integrations.blink',
                        -- make lazydev completions top priority (see `:h blink.cmp`)
                        score_offset = 100,
                    },
                },
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
