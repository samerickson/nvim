vim.o.sw = 4
vim.o.ts = 4
vim.o.et = true

vim.o.number = true
vim.o.mouse = 'a'

-- Show whitespace.
vim.opt.list = true
vim.opt.listchars = { space = '⋅', trail = '⋅', tab = '  ↦' }

vim.o.updatetime = 300
vim.o.timeoutlen = 500
vim.o.ttimeoutlen = 10

vim.o.completeopt = 'menuone,noselect,noinsert'

-- Status line.
vim.o.laststatus = 3
vim.o.cmdheight = 1

-- Disable health checks for these providers.
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

vim.o.clipboard = 'unnamedplus'

vim.wo.signcolumn = 'yes'
