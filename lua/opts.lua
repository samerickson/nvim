local tabSize = 2
local set = vim.opt

set.relativenumber = true
set.number = true

---@diagnostic disable-next-line: undefined-field
local osname = vim.loop.os_uname().sysname

if osname == "Linux" then
  set.shell = "bash"
elseif osname == "Windows_NT" then
  set.shell = "pwsh"
end

set.undofile = true

set.shellcmdflag="-command"

set.shellquote="\""
set.shellxquote=""

set.tabstop = tabSize
set.shiftwidth = tabSize
set.softtabstop = tabSize
set.expandtab = true
set.swapfile = false
set.list = true

set.scrolloff = 10
set.numberwidth = 5

-- Have gutter be used even if line number are not being displayed
set.signcolumn = "yes"

set.updatetime = 1000
set.cmdheight = 1

set.listchars = {tab='» ', extends='⟩', precedes='⟨', trail='•'}

set.colorcolumn = "120"

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Highlight yank selection
autocmd('TextYankPost', {
    group = augroup('HighlightYank', {}),
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 120,
        })
    end,
})

-- Ensure help files always open as a vertical split
autocmd("FileType", {
  pattern = "help",
  command = "wincmd L"
})

