local tabSize = 2
local set = vim.opt

set.relativenumber = true
set.number = true

local osname = vim.loop.os_uname().sysname

if osname == "Linux" then
  set.shell = "bash"
elseif osname == "Windows_NT" then
  set.shell = "pwsh"
end

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

-- Always open help files in a left vertical pane
vim.api.nvim_exec(
[[augroup helpfiles
au!
au BufRead,BufEnter */doc/* wincmd L
augroup END]],
false)

