if vim.env.VSCODE then
  vim.g.vscode = true
end

require("config.lazy")({
  debug = false,
  profiling = {
    loader = false,
    require = false,
  },
})
