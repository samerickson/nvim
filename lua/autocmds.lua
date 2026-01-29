vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'c', 'cpp', 'go', 'lua' },
    callback = function()
        vim.bo.shiftwidth = 4
        vim.bo.tabstop = 4
        vim.bo.softtabstop = 4
        vim.bo.expandtab = true
    end,
})
