local tabSize = 2
local set = vim.opt

set.relativenumber = true
set.number = true

set.undofile = true

set.shellcmdflag="-command"

set.shellquote="\""
set.shellxquote=""

-- set.autochdir = true

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

