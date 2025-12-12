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
vim.o.timeoutlen = 200
vim.o.ttimeoutlen = 10

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.signcolumn = 'yes'
vim.o.inccommand = 'split'
vim.o.cursorline = true

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

vim.o.scrolloff = 12

-- Disable health checks for these providers.
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

if vim.fn.has 'wsl' == 1 then
    vim.api.nvim_create_autocmd('TextYankPost', {
        callback = function()
            vim.schedule(function()
                vim.fn.system('clip.exe', vim.fn.getreg '0')
            end)
        end,
    })
end
