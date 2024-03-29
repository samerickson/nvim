return {
  {
    'nvim-treesitter/playground',
    lazy = true,
    cmd = 'TSPlaygroundToggle'
  },
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      { 'nvim-treesitter/nvim-treesitter-context' },
    },
    lazy = true,
    event = "VeryLazy",
    config = function()
      require 'nvim-treesitter.install'.compilers = { "clang" }
      require 'nvim-treesitter.install'.prefer_git = true

      require 'nvim-treesitter.configs'.setup {
        -- A list of parser names, or "all"
        ensure_installed = { "javascript", "typescript", "c", "lua", "rust", "vim", "vimdoc", "bash" },

        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,

        -- Automatically install missing parsers when entering buffer
        -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
        auto_install = false,

        highlight = {
          -- `false` will disable the whole extension
          enable = true,
          -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
          -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
          -- Using this option may slow down your editor, and you may see some duplicate highlights.
          -- Instead of true it can also be a list of languages
          additional_vim_regex_highlighting = false,
        },

        tree_docs = { enable = true }
      }
    end
  }
}
