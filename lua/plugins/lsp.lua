return {
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    event = "VeryLazy",
    lazy = true,
    dependencies = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' },
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'hrsh7th/cmp-nvim-lua' },
      { 'hrsh7th/cmp-nvim-lsp-signature-help' },

      -- Snippets
      { 'L3MON4D3/LuaSnip' },

      -- To register keybindings
      { "folke/which-key.nvim" },
    },
    config = function()
      local lsp_zero = require('lsp-zero')

      local util = require'lspconfig.util'

      require('mason').setup({})
      require('mason-lspconfig').setup({
        ensure_installed = { 'tsserver', 'rust_analyzer' },
        handlers = {
          lsp_zero.default_setup,
          lua_ls = function()
            local lua_opts = lsp_zero.nvim_lua_ls()
            require('lspconfig').lua_ls.setup(lua_opts)
          end,
          gopls = function()
            require("lspconfig").gopls.setup {
              root_dir = function(fname)
                return util.root_pattern 'go.work' (fname) or util.root_pattern('go.mod', '.git')(fname)
              end,
            }
          end
        }
      })


      vim.api.nvim_create_autocmd('LspAttach', {
        desc = 'LSP actions',
        callback = function(event)
          local opts = { buffer = event.buf }

          local wk = require("which-key")
          wk.register({
            g = {
              k = { '<cmd>lua vim.lsp.buf.hover()<cr>', "🛸 Lsp Hover", opts },
              d = { '<cmd>lua vim.lsp.buf.definition()<cr>', "🗺️ Jump to definition", opts },
              D = { '<cmd>lua vim.lsp.buf.declaration()<cr>', "📍 Jump to declaration", opts },
              i = { '<cmd>lua vim.lsp.buf.implementation()<cr>', "🧱 Jump to implementation", opts },
              o = { '<cmd>lua vim.lsp.buf.type_definition()<cr>', "🌀 Jump to type definition", opts },
              r = { '<cmd>lua vim.lsp.buf.references()<cr>', "📃 See references", opts },
              s = { '<cmd>lua vim.lsp.buf.signature_help()<cr>', "✒️ Signature help",opts },
              f = { '<cmd>lua vim.diagnostic.open_float()<cr>', "🛟 Open diagnostics", opts },
            },
            ["[d"] = { '<cmd>lua vim.diagnostic.goto_prev()<cr>', "🦘 Jump to previous diagnostic", opts },
            ["]d"] = { '<cmd>lua vim.diagnostic.goto_next()<cr>', " 🦘 Jump to next diagnostic", opts },
            ["<F4>"] = { '<cmd>lua vim.lsp.buf.code_action()<cr>', "🤖 See code action", opts },
            ["<F3>"] = { '<cmd>lua vim.lsp.buf.format({async = true})<cr>', "📝 Format document", opts },
            ["<F2>"] = { '<cmd>lua vim.lsp.buf.rename()<cr>', "✍️  Rename", opts },
          })
        end
      })

      local cmp = require('cmp')
      cmp.setup({
        formatting = lsp_zero.cmp_format(),
        mapping = cmp.mapping.preset.insert({
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<Tab>'] = cmp.mapping.confirm({ select = true }),
          ['<CR>'] = cmp.mapping.confirm({ select = false }),
        })
      })
    end
  }
}
