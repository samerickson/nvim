-- Enable experimental loader
vim.loader.enable()
vim.o.shell = '/usr/sbin/dash'

require 'options'
require 'keymaps'

if not require('samerickson.utils').is_windows then
    require('vim._core.ui2').enable {}
end

vim.lsp.enable 'lua_ls'
