return {
  {
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build =
        'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
        config = function()
          require("telescope").load_extension("fzf")
        end
      }
    },
    config = function()
      require('telescope').setup {
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
            ".opam",
            "snap/*",
            ".rsync_*",
            "node_modules",
            "zig%-cache",
            ".cache",
            "x64",
            "coverage",
            "help",
            "Help",
            "_build",
            "%.git/"
          }
        }
      }

      -- Telescope remappings
    end
  }
}
