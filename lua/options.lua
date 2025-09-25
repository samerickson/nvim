-- Use Windows clipboard via clip.exe in WSL
vim.g.clipboard = {
    name = 'WslClipboard',
    copy = {
        ['+'] = 'clip.exe',
        ['*'] = 'clip.exe',
    },
    paste = {
        ['+'] = 'powershell.exe -c Get-Clipboard',
        ['*'] = 'powershell.exe -c Get-Clipboard',
    },
    cache_enabled = 0,
}

vim.o.clipboard = 'unnamedplus'

-- Set <space> as the leader key.
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Use a default of 4 spaces for indentation
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.expandtab = true

-- Show whitespace.
vim.opt.list = true
vim.opt.listchars = { space = '⋅', trail = '⋅', tab = '  ↦' }

-- Save undo history
vim.o.undofile = true

-- Show line numbers.
vim.wo.number = true

-- Enable mouse mode.
vim.o.mouse = 'a'

-- Wrap long lines at words.
vim.o.linebreak = true

-- Folding.
vim.o.foldcolumn = '1'
vim.o.foldlevelstart = 99
vim.wo.foldtext = ''

-- Use rounded borders for floating windows.
vim.o.winborder = 'rounded'

-- Decrease update time
vim.o.updatetime = 150

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 200

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

vim.o.scrolloff = 8
