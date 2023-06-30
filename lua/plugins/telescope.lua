return {
  {
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
    },
    opts = {
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
      defaults = {
        prompt_prefix = "🔎 ",
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
          "x64",
          "coverage",
          "help",
          "Help"
        }
      }
    },
    init = function()
      -- Telescope remappings
      local opts = { noremap = true }
      local builtin = require("telescope.builtin")
      local themes = require('telescope.themes');

      local custom_picker_directory = function(title, directory)
        return themes.get_dropdown {
          previewer = false,
          cwd = directory,
          prompt_title = title,
        }
      end

      vim.keymap.set('', '<C-p>', ':Telescope git_files<CR>', opts)
      vim.keymap.set('', '<A-p>', ':Telescope quickfix<CR>', opts)
      vim.keymap.set('', '<C-t>', ':Telescope fd hidden=true<CR>', opts)
      vim.keymap.set('', '<C-f>', ':Telescope current_buffer_fuzzy_find<CR>', opts)
      vim.keymap.set('', '<A-f>', ':Telescope live_grep<CR>', opts)
      vim.keymap.set('', '<A-t>', ':Telescope vim_options<CR>', opts)
      vim.keymap.set('', '<A-p>', ':Telescope commands<CR>', opts)
      vim.keymap.set('', '<C-b>', ':Telescope buffers<CR>', opts)
      vim.keymap.set('', '<C-h>', ':Telescope oldfiles<CR>', opts)

      vim.keymap.set('n', '<leader>tgf', ':Telescope git_files hidden=true<CR>', opts)
      vim.keymap.set('n', '<leader>tgb', ':Telescope git_branches<CR>', opts)
      vim.keymap.set('n', '<leader>tgc', ':Telescope git_commits<CR>', opts)
      vim.keymap.set('n', '<leader>tgs', ':Telescope git_stash<CR>', opts)
      vim.keymap.set('n', '<leader>tgi', ':Telescope git_status<CR>', opts)

      -- Open dotfiles in telescope
      vim.keymap.set('n', '<leader>td', function()
        builtin.git_files(custom_picker_directory("🐡 Dotfiles 🐠", "~/dev/personal/dotfiles"))
      end, opts)

      -- Open neovim files in telescope
      vim.keymap.set('n', '<leader>tn', function()
        builtin.find_files(
          custom_picker_directory("🗽 Neovim Configuration Files🗼", "~/dev/personal/dotfiles/nvim/.config/nvim"))
      end);

      vim.keymap.set('n', '<leader>tvo', ':Telescope oldfiles<CR>', opts)

      vim.keymap.set('n', '<leader>to', ':Telescope fd hidden=true<CR>', opts)
      vim.keymap.set('n', '<leader>tb', ':Telescope buffers<CR>', opts)
      vim.keymap.set('n', '<leader>tc', ':Telescope commands<CR>', opts)
      vim.keymap.set('n', '<leader>tf', ':Telescope current_buffer_fuzzy_find<CR>', opts)
      vim.keymap.set('n', '<leader>ts', ':Telescope live_grep<CR>', opts)
      vim.keymap.set('n', '<leader>tq', ':Telescope quickfix<CR>', opts)
      vim.keymap.set('n', '<leader>to', ':Telescope vim_options<CR>', opts)
      vim.keymap.set('n', '<leader>tt', ':Telescope<CR>', opts)
    end
  }
}
