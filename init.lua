vim.g.mapleader = ' '

---@diagnostic disable-next-line: undefined-field
local osname = vim.loop.os_uname().sysname
local node_bin
local home_dir

if osname == "Linux" then
  node_bin = "/.local/share/fnm/node-versions/v21.6.1/installation/bin"
  home_dir = os.getenv( "HOME" )
  vim.opt.shell = "bash"

elseif osname == "Windows_NT" then
  node_bin = "\\AppData\\Roaming\\fnm\\node-versions\\v21.6.1\\installation"
  home_dir = "C:" .. os.getenv("HOMEPATH")
  vim.opt.set.shell = "pwsh"
end

local node_path = home_dir .. node_bin

if require("util").os.exists(node_path) then
  -- https://jaketrent.com/post/set-node-version-nvim/
  vim.g.node_host_prog = node_path .. "/neovim-node-host"

  -- for mason.nvim
  -- prereq - install lsp server in that node/bin npm i -g typescript-language-server
  -- (handled by :Mason currently)
  vim.cmd("let $PATH = '" .. node_path .. ";' . $PATH")
else
  error("Node version v21.6.1 is not installed.")
end

require("opts")
require("plugins")
require("remap")
require("autocmds")

