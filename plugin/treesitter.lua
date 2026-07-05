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

vim.pack.add { 'https://github.com/nvim-treesitter/nvim-treesitter' }

local init = vim.api.nvim_get_runtime_file('lua/nvim-treesitter/init.lua', false)[1]
if init then
    vim.opt.runtimepath:prepend(vim.fn.fnamemodify(init, ':h:h:h') .. '/runtime')
end

require('nvim-treesitter').setup {
    -- Directory to install parsers and queries to (prepended to `runtimepath` to have priority)
    highlight = { enable = true },
}

vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'cpp' },
    callback = function()
        vim.treesitter.start()
    end,
})

require('nvim-treesitter').install(parsers):wait(300000)

vim.api.nvim_create_autocmd('FileType', {
    callback = function(args)
        pcall(vim.treesitter.start, args.buf)
    end,
})
