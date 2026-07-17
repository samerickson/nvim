---@class SamEricksonUtils
---@field open_link fun(): string|nil error message when system command fails
---Utility helpers for Sam Erickson's Neovim config.
---Keep UI-focused helper functions consolidated here.
local M = {} ---@type SamEricksonUtils

M.is_windows = (vim.uv or vim.loop).os_uname().sysname == 'Windows_NT'

return M
