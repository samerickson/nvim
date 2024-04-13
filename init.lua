if vim.env.VSCODE then
  vim.g.vscode = true
end

if vim.g.neovide then
  -- Put anything you want to happen only in Neovide here
  -- vim.g.neovide_fullscreen = true
  vim.g.neovide_cursor_animation_length = 0.03
  vim.o.guifont = "CaskaydiaCove_NF:h13"
end

require("config.lazy")({
  debug = false,
  profiling = {
    loader = false,
    require = false,
  },
})
