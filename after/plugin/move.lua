local opts = { noremap = true, silent = true }

vim.keymap.set('i', '<A-DOWN>', ':MoveLine(1)<CR>', opts)
vim.keymap.set('i', '<A-UP>', ':MoveLine(-1)<CR>', opts)
vim.keymap.set('i', '<A-LEFT>', ':MoveHChar(-1)<CR>', opts)
vim.keymap.set('i', '<A-RIGHT>', ':MoveHChar(1)<CR>', opts)

vim.keymap.set('n', '<A-DOWN>', ':MoveLine(1)<CR>', opts)
vim.keymap.set('n', '<A-UP>', ':MoveLine(-1)<CR>', opts)
vim.keymap.set('n', '<A-LEFT>', ':MoveHChar(-1)<CR>', opts)
vim.keymap.set('n', '<A-RIGHT>', ':MoveHChar(1)<CR>', opts)


vim.keymap.set('v', '<A-DOWN>', ':MoveBlock(1)<CR>', opts)
vim.keymap.set('v', '<A-UP>', ':MoveBlock(-1)<CR>', opts)
vim.keymap.set('v', '<A-LEFT>', ':MoveHBlock(-1)<CR>', opts)
vim.keymap.set('v', '<A-RIGHT>', ':MoveHBlock(1)<CR>', opts)
