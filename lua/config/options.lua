-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

---@diagnostic disable-next-line: undefined-field
local osname = vim.loop.os_uname().sysname
local node_bin
local home_dir
local neovim_node_prog

if osname == "Linux" then
  node_bin = "/.local/share/fnm/node-versions/v21.6.1/installation/bin"
  home_dir = os.getenv("HOME")
  neovim_node_prog = "neovim-node-host"
  -- vim.opt.shell = "bash"
elseif osname == "Windows_NT" then
  node_bin = "\\AppData\\Roaming\\fnm\\node-versions\\v21.6.1\\installation"
  home_dir = "C:" .. os.getenv("HOMEPATH")
  neovim_node_prog = "neovim-node-host.cmd"
  vim.opt.shell = "pwsh"
  vim.opt.shellcmdflag = "-c"
  vim.opt.shellquote = ""
  vim.opt.shellxquote = ""
end

local node_path = home_dir .. node_bin

if require("samerickson.util").os.exists(node_path) then
  -- https://jaketrent.com/post/set-node-version-nvim/
  vim.g.node_host_prog = node_path .. "/" .. neovim_node_prog
  -- vim.cmd("let $PATH = '" .. node_path .. ";' . $PATH")
else
  error("Node version v21.6.1 is not installed.")
end

-- Disable auto format
vim.g.autoformat = false -- globally
vim.b.autoformat = false -- buffer-local
