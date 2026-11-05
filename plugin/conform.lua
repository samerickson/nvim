vim.pack.add { 'https://github.com/stevearc/conform.nvim' }

vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
vim.g.autoformat = true

require('conform').setup {
    notify_on_error = false,
    formatters_by_ft = {
        c = { 'clang-format', timeout_ms = 500, lsp_format = 'fallback' },
        cpp = { 'clang-format', timeout_ms = 500, lsp_format = 'fallback' },
        css = { 'oxfmt', timeout_ms = 500, lsp_format = 'fallback' },
        astro = { 'oxfmt', timeout_ms = 500, lsp_format = 'fallback' },
        graphql = { 'oxfmt', timeout_ms = 500, lsp_format = 'fallback' },
        handlebars = { 'oxfmt', timeout_ms = 500, lsp_format = 'fallback' },
        html = { 'oxfmt', timeout_ms = 500, lsp_format = 'fallback' },
        htmlangular = { 'oxfmt', timeout_ms = 500, lsp_format = 'fallback' },
        javascript = { 'oxfmt', timeout_ms = 500, lsp_format = 'fallback' },
        javascriptreact = { 'oxfmt', timeout_ms = 500, lsp_format = 'fallback' },
        json = { 'oxfmt', timeout_ms = 500, lsp_format = 'fallback' },
        jsonc = { 'oxfmt', timeout_ms = 500, lsp_format = 'fallback' },
        json5 = { 'oxfmt', timeout_ms = 500, lsp_format = 'fallback' },
        less = { 'oxfmt', timeout_ms = 500, lsp_format = 'fallback' },
        lua = { 'stylua' },
        markdown = { 'oxfmt', timeout_ms = 500, lsp_format = 'fallback' },
        mdx = { 'oxfmt', timeout_ms = 500, lsp_format = 'fallback' },
        mjml = { 'oxfmt', timeout_ms = 500, lsp_format = 'fallback' },
        rust = { name = 'rust_analyzer', timeout_ms = 500, lsp_format = 'prefer' },
        scss = { 'oxfmt', timeout_ms = 500, lsp_format = 'fallback' },
        sh = { 'shfmt' },
        svelte = { 'oxfmt', timeout_ms = 500, lsp_format = 'fallback' },
        toml = { 'oxfmt', timeout_ms = 500, lsp_format = 'fallback' },
        typescript = { 'oxfmt', timeout_ms = 500, lsp_format = 'fallback' },
        typescriptreact = { 'oxfmt', timeout_ms = 500, lsp_format = 'fallback' },
        vue = { 'oxfmt', timeout_ms = 500, lsp_format = 'fallback' },
        yaml = { 'oxfmt', timeout_ms = 500, lsp_format = 'fallback' },
        go = { 'goimports', 'gofmt' },
        -- For filetypes without a formatter:
        ['_'] = { 'trim_whitespace', 'trim_newlines' },
    },
    format_on_save = function()
        if not vim.g.autoformat then
            return nil
        end

        return {
            timeout_ms = 2000,
            lsp_fallback = false,
        }
    end,
}
