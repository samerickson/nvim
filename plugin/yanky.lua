vim.pack.add {
    { src = 'https://github.com/gbprod/yanky.nvim' },
}

local ok, yanky = pcall(require, 'yanky')
if not ok then
    return
end

local system_clipboard = {
    sync_with_ring = not vim.env.SSH_CONNECTION,
}

yanky.setup {
    system_clipboard = system_clipboard,
    highlight = { timer = 150 },
}

local map = vim.keymap.set

-- Yanky mappings
map({ 'n', 'x' }, 'y', '<Plug>(YankyYank)', { desc = 'Yank Text' })
map({ 'n', 'x' }, 'p', '<Plug>(YankyPutAfter)', { desc = 'Put Text After Cursor' })
map({ 'n', 'x' }, 'P', '<Plug>(YankyPutBefore)', { desc = 'Put Text Before Cursor' })

map('n', '[y', '<Plug>(YankyCycleForward)', { desc = 'Cycle Forward Through Yank History' })
map('n', ']y', '<Plug>(YankyCycleBackward)', { desc = 'Cycle Backward Through Yank History' })

-- Snacks integration (needs Snacks already loaded)
map({ 'n', 'x' }, '<leader>p', function()
    Snacks.picker.yanky()
end, { desc = 'Open Yank History' })
