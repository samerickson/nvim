vim.g.mapleader = ' '

local opts = { noremap = true, silent = true }

vim.keymap.set('', 'gx', '<Esc>:Explore<Cr>', opts)

-- Keep the cursor in the middle of the screen when scrolling
vim.keymap.set('', '<C-u>', '<C-u>zz', opts)
vim.keymap.set('', '<C-d>', '<C-d>zz', opts)

vim.keymap.set('i', 'jk', '<Esc>', opts)
vim.keymap.set('n', '<leader>s', ':%s/', opts)

vim.keymap.set('', '<C-a>', '<Esc>ggVG')
vim.keymap.set('n', '<C-g>', ':')
vim.keymap.set('i', '<C-g>', '<Esc>:')

-- Terminal mode keybindings
vim.keymap.set('', '<C-_>', ':terminal<CR>', opts)
vim.keymap.set('t', '<C-d>', '<C-\\><C-n>', opts)
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', opts)
vim.keymap.set('t', 'jk', '<C-\\><C-n>', opts)

-- Show/hide line numbers
vim.keymap.set('n', '<leader>n', ':set number!<CR>', opts)
vim.keymap.set('n', '<leader>m', ':set relativenumber!<CR>', opts)

