-- Use Windows clipboard via clip.exe in WSL
-- Install with: winget install win32yank
vim.schedule(function()
    vim.opt.clipboard = 'unnamedplus'
end)

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
vim.o.breakindent = true

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

vim.opt.hidden = true
vim.opt.autoread = true
vim.opt.termguicolors = true

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.o.confirm = true

-- Disable health checks for these providers.
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

-- Indent wrapped lines to match the parent line
vim.opt.breakindent = true

-- Don't break lines in the middle of words when formatting
vim.opt.formatoptions = 'l'

-- Wrap long lines at word boundaries
vim.opt.linebreak = true
