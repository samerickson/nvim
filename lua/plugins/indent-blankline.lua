return {
  {
    -- Shows the indentation level of lines.
    "lukas-reineke/indent-blankline.nvim",
    event = "VeryLazy",
    config = function()
      local highlight = {
        "RainbowRed",
        "RainbowYellow",
        "RainbowBlue",
        "RainbowOrange",
        "RainbowGreen",
        "RainbowViolet",
        "RainbowCyan",
      }

      local hooks = require "ibl.hooks"
      -- create the highlight groups in the highlight setup hook, so they are reset
      -- every time the colorscheme changes
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#6E171E" })
        vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#765517" })
        vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#1E4C52" })
        vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#603d1d" })
        vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#3B5727" })
        vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#5A1b6D" })
        vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
      end)

      require("ibl").setup { indent = { highlight = highlight } }
    end
  }
}
