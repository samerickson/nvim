return {
  {
    -- Shows the indentation level of lines.
    "lukas-reineke/indent-blankline.nvim",
    lazy = false,
    opts = {
      show_current_context = true,
      show_current_context_start = true,
      char_highlight_list = {
        "IndentBlanklineIndent1",
        "IndentBlanklineIndent2",
        "IndentBlanklineIndent3",
        "IndentBlanklineIndent4",
        "IndentBlanklineIndent5",
        "IndentBlanklineIndent6",
      }
    },
    init = function ()
      vim.opt.termguicolors = true
      vim.cmd [[highlight IndentBlanklineIndent1 guifg=#6E171E gui=nocombine]]
      vim.cmd [[highlight IndentBlanklineIndent2 guifg=#765517 gui=nocombine]]
      vim.cmd [[highlight IndentBlanklineIndent3 guifg=#3B5727 gui=nocombine]]
      vim.cmd [[highlight IndentBlanklineIndent4 guifg=#1E4C52 gui=nocombine]]
      vim.cmd [[highlight IndentBlanklineIndent5 guifg=#0C497A gui=nocombine]]
      vim.cmd [[highlight IndentBlanklineIndent6 guifg=#5A1b6D gui=nocombine]]
    end
  }
}
