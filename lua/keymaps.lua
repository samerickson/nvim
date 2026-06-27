local map = vim.keymap.set

-- Quit all
map('n', '<leader>qq', '<cmd>qa<cr>', { desc = 'Quit All', silent = true })

-- Move to window using the <ctrl> hjkl keys
map('n', '<C-h>', '<C-w>h', { desc = 'Go to Left Window' })
map('n', '<C-j>', '<C-w>j', { desc = 'Go to Lower Window' })
map('n', '<C-k>', '<C-w>k', { desc = 'Go to Upper Window' })
map('n', '<C-l>', '<C-w>l', { desc = 'Go to Right Window' })

-- Resize window using <ctrl> arrow keys
map('n', '<C-Up>', '<cmd>resize +2<cr>', { desc = 'Increase Window Height' })
map('n', '<C-Down>', '<cmd>resize -2<cr>', { desc = 'Decrease Window Height' })
map('n', '<C-Left>', '<cmd>vertical resize -2<cr>', { desc = 'Decrease Window Width' })
map('n', '<C-Right>', '<cmd>vertical resize +2<cr>', { desc = 'Increase Window Width' })

-- Move Lines
map('n', '<A-j>', "<cmd>execute 'move .+' . v:count1<cr>==", { desc = 'Move Down' })
map('n', '<A-k>', "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = 'Move Up' })
map('n', '<A-Down>', "<cmd>execute 'move .+' . v:count1<cr>==", { desc = 'Move Down' })
map('i', '<A-k>', '<esc><cmd>m .-2<cr>==gi', { desc = 'Move Up' })
map('v', '<A-j>', ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = 'Move Down' })
map('v', '<A-k>', ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = 'Move Up' })

-- Shell (like) mappings
map('i', '<C-a>', '<C-o>^', { desc = 'Move to begining of text on line' })
map('i', '<A-f>', '<A-w>', { desc = 'Move forward a word' })

map('n', '<C-g>', function()
    vim.cmd ':let @+ = expand("%")'
    vim.notify('Coppied file name to clipboard\n: ' .. vim.fn.getreg '+', vim.log.levels.INFO)
end, { desc = 'Copy name of file to clipboard' })

map('v', '<', '<gv')
map('v', '>', '>gv')

--- Jumps between diagnostics with an optional severity filter.
---@param next boolean when true, jump to next; when false, jump to previous
---@param severity? 'ERROR'|'WARN'|'INFO'|'HINT' optional severity key from `vim.diagnostic.severity`
---@return fun():nil callback to execute the jump
local diagnostic_jump = function(next, severity)
    local sev = severity and vim.diagnostic.severity[severity] or nil
    return function()
        vim.diagnostic.jump { count = next and 1 or -1, severity = sev }
    end
end

map('n', '<leader>cd', vim.diagnostic.open_float, { desc = 'Line Diagnostics' })
map('n', ']d', diagnostic_jump(true), { desc = 'Next Diagnostic' })
map('n', '[d', diagnostic_jump(false), { desc = 'Prev Diagnostic' })
map('n', ']e', diagnostic_jump(true, 'ERROR'), { desc = 'Next Error' })
map('n', '[e', diagnostic_jump(false, 'ERROR'), { desc = 'Prev Error' })
map('n', ']w', diagnostic_jump(true, 'WARN'), { desc = 'Next Warning' })
map('n', '[w', diagnostic_jump(false, 'WARN'), { desc = 'Prev Warning' })

map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit Terminal Mode' })
map('t', '<c-/>', '<cmd>close<cr>', { desc = 'Close terminal' })
map('t', '<c-_>', '<cmd>close<cr>', { desc = 'which_key_ignore' })
map('t', '<c-k>', '<C-\\><C-n><C-w>k', { desc = 'Window up' })

map({ 'v', 'x' }, '<leader>t', function()
    require('samerickson.translate').translate_selection 'fr'
end, { desc = 'Translate selection to French' })

map('n', 'gx', require('samerickson.utils').open_link, { desc = 'Open with system app', silent = true })
