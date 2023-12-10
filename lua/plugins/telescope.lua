return {
  {
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    build = ":TSUpdate",
    keys = { "<leader>t", "<C-P>", "<C-T>" },
    dependencies = {
      { "nvim-lua/plenary.nvim"},
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
        config = function()
          require("telescope").load_extension("fzf")
        end
      }
    },
    config = function()
      require('telescope').setup{
        pickers = {
          live_grep = {
            only_sort_text = true,
            additional_args = function(opts)
              return { "--hidden" }
            end
          },
          grep_string = {
            only_sort_text = true
          },
          find_files = {
            hidden = true
          },
          git_files = {
            hidden = true,
            show_untracked = true
          },
          colorscheme = {
            enable_preview = true,
          },
        },
        grep_string = {
          only_sort_text = true
        },
        find_files = {
          hidden = true
        },
        git_files = {
          hidden = true,
          show_untracked = true
        },
        colorscheme = {
          enable_preview = true,
        },
        defaults = {
          prompt_prefix = "🔎 ",
          layout_stategy = "horizontal",
          layout_config = { prompt_position = "top" },
          sorting_strategy = "ascending",
          winblend = 0,
          vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--hidden",
            "--glob=!.git/",
          },
          file_ignore_patterns = {
            "node_modules",
            "zig%-cache",
            "x64",
            "coverage",
            "help",
            "Help"
          }
        }
      }

      -- Telescope remappings
      local opts = { noremap = true }

      vim.keymap.set('n', '<leader>to', ':Telescope fd hidden=true<CR>', opts)
      vim.keymap.set('n', '<leader>tb', ':Telescope buffers<CR>', opts)
      vim.keymap.set('n', '<leader>tc', ':Telescope commands<CR>', opts)
      vim.keymap.set('n', '<leader>tf', ':Telescope current_buffer_fuzzy_find<CR>', opts)
      vim.keymap.set('n', '<leader>ts', ':Telescope live_grep<CR>', opts)
      vim.keymap.set('n', '<leader>tq', ':Telescope quickfix<CR>', opts)
      vim.keymap.set('n', '<leader>tO', ':Telescope oldfiles<CR>', opts)
      vim.keymap.set('n', '<leader>tt', ':Telescope<CR>', opts)
      vim.keymap.set('n', '<leader>ti', ':Telescope diagnostics<CR>', opts)

      vim.keymap.set('', '<C-p>', ':Telescope git_files<CR>', opts)
      vim.keymap.set('', '<A-p>', ':Telescope quickfix<CR>', opts)
      vim.keymap.set('', '<C-t>', ':Telescope fd hidden=true<CR>', opts)
      vim.keymap.set('', '<C-f>', ':Telescope current_buffer_fuzzy_find<CR>', opts)
      vim.keymap.set('', '<A-f>', ':Telescope live_grep<CR>', opts)
      vim.keymap.set('', '<A-t>', ':Telescope vim_options<CR>', opts)
      vim.keymap.set('', '<A-p>', ':Telescope commands<CR>', opts)
      vim.keymap.set('', '<C-b>', ':Telescope buffers<CR>', opts)
      vim.keymap.set('', '<C-h>', ':Telescope oldfiles<CR>', opts)

      vim.keymap.set('n', '<leader>tvo', ':Telescope vim_options<CR>', opts)
      vim.keymap.set('n', '<leader>tvc', ':Telescope commands<CR>', opts)

      vim.keymap.set('n', '<leader>tgf', ':Telescope git_files hidden=true<CR>', opts)
      vim.keymap.set('n', '<leader>tgb', ':Telescope git_branches<CR>', opts)
      vim.keymap.set('n', '<leader>tgc', ':Telescope git_commits<CR>', opts)
      vim.keymap.set('n', '<leader>tgs', ':Telescope git_stash<CR>', opts)
      vim.keymap.set('n', '<leader>tgi', ':Telescope git_status<CR>', opts)

      -- Open dotfiles in telescope
      vim.keymap.set('n', '<leader>td', function () require("util").telescope.get_dotfiles() end, opts)

      -- Open neovim files in telescope
      vim.keymap.set('n', '<leader>tn', function() require("util").telescope.get_configfiles() end)
    end
  }
}
