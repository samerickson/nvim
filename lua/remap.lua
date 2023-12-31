local opts = { noremap = true, silent = true }

-- Keep the cursor in the middle of the screen when scrolling
vim.keymap.set('', '<C-u>', '<C-u>zz', opts)
vim.keymap.set('', '<C-d>', '<C-d>zz', opts)

vim.keymap.set('i', 'jk', '<Esc>', opts)

-- Terminal mode keybindings
vim.keymap.set('t', '<C-d>', '<C-\\><C-n>', opts)
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', opts)
vim.keymap.set('t', 'jk', '<C-\\><C-n>', opts)

local wk = require("which-key")
wk.register({
  ["<C-p>"] = { ":Telescope git_files<CR>", "📝 git Files" },
  ["<C-f"] = { ":Telescope current_buffer_fuzzy_find<CR>", "📃 Search in current file" },
  ["<C-h>"] = { ":Telescope help_tags<CR>", "❓ Help Docs" },
  ["C-b"] = { ":Telescope buffers<CR>", "🦬 Buffers" },
  ["<leader>"] = {
    g = {
      name = "📑 Git",
      s = {":Gitsigns stage_hunk<CR>", "➕ Stage hunk"},
      u = {":Gitsigns unstage_hunk<CR>", "➖ Unstage hunk"},
      r = {":Gitsigns reset_hunk<CR>", "🗑️ Reset hunk"},
      S = {":Gitsigns stage_buffer<CR>", " 📜 Stage buffer"},
      R = {":Gitsigns reset_buffer<CR>", "⛑️  Reset buffer"},
      p = {":Gitsigns preview_hunk<CR>" ," 🎥 Preview hunk"},
      b = {":Gitsigns blame_line<CR>", " 👉 Blame line"},
      d = {":Gitsigns diffthis<CR>" ,"diff this"},
      t = {
        name = " 🎛️ toggle",
        b = {":Gitsigns toggle_current_line_blame<CR>", "👉 Git blame current line"},
        d = {":Gitsigns toggle_deleted<CR>", "🗑️ display deleted"}
      }
    },
    c = {
      name = "📂 Custom Directories",
      d = { require("util").telescope.get_dotfiles, "🐡 dotfiles" },
      n = { require("util").telescope.get_config_files, "🐠 neovim configuration files" },
      h = { require("util").telescope.get_home_files, "🏠 Home folder" },
    },
    e = { ":Explore<CR>", "📂 File Explorer" },
    t = {
      name = " 🔭 Telescope",
      t = { ":Telescope<CR>", "🔭 telescope" },
      o = { ":Telescope fd hidden=true<CR>", "📜 find files" },
      O = { ":Telescope oldfiles<CR>", "👴 old files" },
      q = { ":Telescope quickfix<CR>", "🛠️ quickfix" },
      f = { ":Telescope current_buffer_fuzzy_find<CR>", "📃 find in current file" },
      s = { ":Telescope live_grep<CR>", "🐚 live grep" },
      b = { ":Telescope buffers<CR>", "🗃️ search buffers" },
      d = { ":Telescope diagnostics<CR>", "⚠️  View diagnostics" },
      v = {
        name = "🦙 vim configuration",
        o = { ":Telescope vim_options<CR>", " ⚙️ vim options" },
        c = { ":Telescope commands<CR>", "🎬 vim commands" },
      },
      g = {
        name = "📦 git",
        f = { ":Telescope git_files hidden=true<CR>", "📝 files" },
        b = { ":Telescope git_branches<CR>", "🌿 branches" },
        c = { ":Telescope git_commits<CR>", "🔍 commits" },
        s = { ":Telescope git_stash<CR>", "💼 stashes" },
        i = { ":Telescope git_status<CR>", "🗽 status" },
      }
    },
    d = {
      name = "📃 Documentation",
      g = { ":lua require('neogen').generate()<cr>", "🧬 Generate documentation" }
    }
  }
})

