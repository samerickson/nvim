return {
  'nvim-neo-tree/neo-tree.nvim',
  cmd = "Neotree",
  dependencies = {
    { "nvim-lua/plenary.nvim" },
    { "nvim-tree/nvim-web-devicons" }, -- not strictly required, but recommended
    { "MunifTanjim/nui.nvim" }
  },
  init = function ()
    -- Unless you are still migrating, remove the deprecated commands from v1.x
    vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
  end
}

