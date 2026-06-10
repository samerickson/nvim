vim.pack.add{ "https://github.com/stevearc/conform.nvim" }

vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
vim.g.autoformat = true

require"conform".setup({
    notify_on_error = false,
    formatters_by_ft = {
        c = { 'clang-format', timeout_ms = 500, lsp_format = 'fallback' },
        cpp = { 'clang-format', timeout_ms = 500, lsp_format = 'fallback' },
        javascript = { 'prettier', 'dprint', timeout_ms = 500, lsp_format = 'fallback', stop_after_first = true },
        javascriptreact = { 'prettier', 'dprint', timeout_ms = 500, lsp_format = 'fallback', stop_after_first = true },
        json = { 'prettier', 'dprint', timeout_ms = 500, lsp_format = 'fallback', stop_after_first = true },
        jsonc = { 'prettier', 'dprint', timeout_ms = 500, lsp_format = 'fallback', stop_after_first = true },
        less = { 'prettier' },
        lua = { 'stylua' },
        markdown = { 'prettier' },
        rust = { name = 'rust_analyzer', timeout_ms = 500, lsp_format = 'prefer' },
        scss = { 'prettier' },
        sh = { 'shfmt' },
        typescript = { 'prettier', 'dprint', timeout_ms = 500, lsp_format = 'fallback', stop_after_first = true },
        typescriptreact = { 'prettier', 'dprint', timeout_ms = 500, lsp_format = 'fallback', stop_after_first = true },
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
    formatters = {
        prettier = { require_cwd = true },
    },
})
