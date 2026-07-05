local start = vim.loop.hrtime()

-- Enable faster startup by caching compiled Lua modules
vim.loader.enable()

vim.api.nvim_create_autocmd('VimEnter', {
    callback = function()
        local ms = (vim.loop.hrtime() - start) / 1e6
        vim.schedule(function()
            print('Startup: ' .. string.format('%.2f ms', ms))
        end)
    end,
})

vim.o.shell = '/bin/bash'

-- Set <space> as the leader key.
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require 'options'
require 'keymaps'
require 'notes'

if not require('samerickson.utils').is_windows then
    require('vim._core.ui2').enable {}
end

vim.lsp.enable 'lua_ls'
vim.lsp.enable 'bashls'
vim.lsp.enable 'vue_ls'
vim.lsp.enable 'vtsls'
vim.lsp.enable 'gopls'
vim.lsp.enable 'eslint'
vim.lsp.enable 'harper_ls'
vim.lsp.enable 'marksman'
vim.lsp.enable 'clangd'

vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function()
        vim.hl.hl_op()
    end,
})
