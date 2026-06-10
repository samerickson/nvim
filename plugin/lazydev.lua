vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'lua' },
    callback = function()
        local gh = require('samerickson.pack').gh
        vim.pack.add { gh 'folke/lazydev.nvim' }

        require('lazydev').setup {
            library = {
                { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
                { path = 'snacks.nvim', words = { 'Snacks' } },
            },
        }
    end,
})
