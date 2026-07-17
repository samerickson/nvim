vim.pack.add {
    'https://github.com/selimacerbas/live-server.nvim',
    'https://github.com/MeanderingProgrammer/render-markdown.nvim',
}

vim.api.nvim_create_autocmd('FileType', {
    once = true,
    pattern = { 'markdown' },
    callback = function()
        require('render-markdown').setup {
            code = {
                sign = true,
                width = 'block',
                right_pad = 1,
            },
            heading = {
                sign = true,
                icons = {},
            },
            checkbox = {
                enabled = true,
            },
        }

        vim.opt_local.conceallevel = 2
    end,
})
