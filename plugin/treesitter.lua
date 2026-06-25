local on_plugin_update = require('samerickson.pack').on_plugin_update
local gh = require('samerickson.pack').gh

local parsers = {
    'bash',
    'c',
    'cpp',
    'css',
    'fish',
    'gitcommit',
    'graphql',
    'html',
    'java',
    'javascript',
    'json',
    'json5',
    'lua',
    'markdown',
    'markdown_inline',
    'python',
    'query',
    'rasi',
    'regex',
    'rust',
    'scss',
    'toml',
    'tsx',
    'typescript',
    'vim',
    'vimdoc',
    'vue',
    'yaml',
    'zig',
}

vim.pack.add { gh 'nvim-treesitter/nvim-treesitter' }

require('nvim-treesitter').setup {
    -- Directory to install parsers and queries to (prepended to `runtimepath` to have priority)
    install_dir = vim.fn.stdpath 'data' .. '/site',
    highlight = { enable = true },
}

require('nvim-treesitter').install(parsers):wait(300000)

vim.api.nvim_create_autocmd('FileType', {
    callback = function(args)
        pcall(vim.treesitter.start, args.buf)
    end,
})
