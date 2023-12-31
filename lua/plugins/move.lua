return {
  'fedepujol/move.nvim', -- Move blocks of text easily
  cmd = { 'MoveLine', 'MoveBlock', 'MoveHChar', 'MoveHBlock', 'MoveWord' },
  keys = { '<A-UP>', '<A-DOWN>', '<A-LEFT>', '<A-RIGHT>'},
  config = function()
    local opts = { noremap = true, silent = true }

    vim.keymap.set('i', '<A-DOWN>', '<Esc>:MoveLine(1)<CR>', opts)
    vim.keymap.set('i', '<A-UP>', '<Esc>:MoveLine(-1)<CR>', opts)
    vim.keymap.set('i', '<A-LEFT>', '<Esc>:MoveHChar(-1)<CR>', opts)
    vim.keymap.set('i', '<A-RIGHT>', '<Esc>:MoveHChar(1)<CR>', opts)

    vim.keymap.set('n', '<A-DOWN>', ':MoveLine(1)<CR>', opts)
    vim.keymap.set('n', '<A-UP>', ':MoveLine(-1)<CR>', opts)
    vim.keymap.set('n', '<A-LEFT>', ':MoveHChar(-1)<CR>', opts)
    vim.keymap.set('n', '<A-RIGHT>', ':MoveHChar(1)<CR>', opts)

    vim.keymap.set('v', '<A-DOWN>', ':MoveBlock(1)<CR>', opts)
    vim.keymap.set('v', '<A-UP>', ':MoveBlock(-1)<CR>', opts)
    vim.keymap.set('v', '<A-LEFT>', ':MoveHBlock(-1)<CR>', opts)
    vim.keymap.set('v', '<A-RIGHT>', ':MoveHBlock(1)<CR>', opts)
  end
}
