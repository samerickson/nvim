-- Enable experimental loader
vim.loader.enable()
vim.o.shell = '/usr/sbin/dash'

require 'options'
require 'keymaps'

if not require('samerickson.utils').is_windows then
    require('vim._core.ui2').enable {}
end

vim.lsp.enable 'lua_ls'
vim.lsp.enable 'bashls'
vim.lsp.enable 'vue_ls'
vim.lsp.enable 'vtsls'
vim.lsp.enable 'gopls'

vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function()
        vim.hl.hl_op()
    end,
})
