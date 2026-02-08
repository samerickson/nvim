-- Most of this file has been taken from https://github.com/AstroNvim/AstroNvim/blob/main/lua/astronvim/plugins/blink.lua#L130

local function has_words_before()
    local line, col = (unpack or table.unpack)(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match '%s' == nil
end

return {
    {
        'saghen/blink.cmp',
        version = '^1',
        event = { 'InsertEnter', 'CmdlineEnter' },
        opts = {
            appearance = {
                nerd_font_variant = 'mono',
            },
            keymap = {
                ['<C-Space>'] = { 'show', 'show_documentation', 'hide_documentation' },
                ['<Up>'] = { 'select_prev', 'fallback' },
                ['<Down>'] = { 'select_next', 'fallback' },
                ['<C-N>'] = { 'select_next', 'show' },
                ['<C-P>'] = { 'select_prev', 'show' },
                ['<C-J>'] = { 'select_next', 'fallback' },
                ['<C-K>'] = { 'select_prev', 'fallback' },
                ['<C-U>'] = { 'scroll_documentation_up', 'fallback' },
                ['<C-D>'] = { 'scroll_documentation_down', 'fallback' },
                ['<C-e>'] = { 'hide', 'fallback' },
                ['<CR>'] = { 'accept', 'fallback' },
                ['<Tab>'] = {
                    'select_next',
                    'snippet_forward',
                    function(cmp)
                        if has_words_before() or vim.api.nvim_get_mode().mode == 'c' then
                            return cmp.show()
                        end
                    end,
                    'fallback',
                },
                ['<S-Tab>'] = {
                    'select_prev',
                    'snippet_backward',
                    function(cmp)
                        if vim.api.nvim_get_mode().mode == 'c' then
                            return cmp.show()
                        end
                    end,
                    'fallback',
                },
                sources = {
                    default = { 'lsp', 'path', 'snippets', 'buffer' },
                },
            },
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
        },
        cmdline = { completion = { ghost_text = { enabled = false } } },
        signature = {
            enabled = true,
            window = {
                border = 'rounded',
                winhighlight = 'Normal:NormalFloat,FloatBorder:FloatBorder',
            },
        },
    },
}
