local M = {
  troubleNextBinding = {
    function () require("trouble").next({ skip_groups = true, jump = true }) end, "🚦 Trouble Next"
  },
  troublePreviousBinding = {
    function () require("trouble").previous({ skip_groups = true, jump = true }) end, "🚦 Trouble Previous"
  },
  searchForWordUnderCursor = function ()
    require("telescope.builtin").grep_string({ search = vim.fn.expand("<cword>") })
  end,
}

local opts = { noremap = true, silent = true }

-- Keep the cursor in the middle of the screen when scrolling
vim.keymap.set('', '<C-u>', '<C-u>zz', opts)
vim.keymap.set('', '<C-d>', '<C-d>zz', opts)

vim.keymap.set('i', 'jk', '<Esc>', opts)

-- Terminal mode keybindings
vim.keymap.set('t', '<C-d>', '<C-\\><C-n>', opts)
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', opts)
vim.keymap.set('t', 'jk', '<C-\\><C-n>', opts)

vim.api.nvim_create_autocmd('LspAttach', {
  desc = '💬 LSP actions',
  callback = function(event)
    local lsp_remap_opts = { buffer = event.buf }

    local wk = require("which-key")
    wk.register({
      g = {
        k = { '<cmd>lua vim.lsp.buf.hover()<cr>', "🛸 Lsp Hover", lsp_remap_opts },
        d = { '<cmd>lua vim.lsp.buf.definition()<cr>', "🗺️ Jump to definition", lsp_remap_opts },
        D = { '<cmd>lua vim.lsp.buf.declaration()<cr>', "📍 Jump to declaration", lsp_remap_opts },
        i = { '<cmd>lua vim.lsp.buf.implementation()<cr>', "🧱 Jump to implementation", lsp_remap_opts },
        o = { '<cmd>lua vim.lsp.buf.type_definition()<cr>', "🌀 Jump to type definition", lsp_remap_opts },
        r = { '<cmd>lua vim.lsp.buf.references()<cr>', "📃 See references", lsp_remap_opts },
        s = { '<cmd>lua vim.lsp.buf.signature_help()<cr>', "✒️ Signature help",lsp_remap_opts },
        f = { '<cmd>lua vim.diagnostic.open_float()<cr>', "🛟 Open diagnostics", lsp_remap_opts },
      },
      ["[d"] = { '<cmd>lua vim.diagnostic.goto_prev()<cr>', "🦘 Jump to previous diagnostic", lsp_remap_opts },
      ["]d"] = { '<cmd>lua vim.diagnostic.goto_next()<cr>', " 🦘 Jump to next diagnostic", lsp_remap_opts },
      ["<F4>"] = { '<cmd>lua vim.lsp.buf.code_action()<cr>', "🤖 See code action", lsp_remap_opts },
      ["<F3>"] = { '<cmd>lua vim.lsp.buf.format({async = true})<cr>', "📝 Format document", lsp_remap_opts },
      ["<F2>"] = { '<cmd>lua vim.lsp.buf.rename()<cr>', "✍️  Rename", lsp_remap_opts },
    })
  end
})

local wk = require("which-key")
wk.register({
  ["<C-p>"] = { ":Telescope git_files<CR>", "📝 git Files" },
  ["<C-f"] = { ":Telescope current_buffer_fuzzy_find<CR>", "📃 Search in current file" },
  ["<C-h>"] = { ":Telescope help_tags<CR>", "❓ Help Docs" },
  ["C-b"] = { ":Telescope buffers<CR>", "🦬 Buffers" },
  ["]"] = {
    t = M.troubleNextBinding
  },
  ["["] = {
    t = M.troublePreviousBinding
  },
  ["<leader>"] = {
    z = { ":ZenMode<CR>", "🧘 Zen mode"},
    T = { ":TroubleToggle<CR>", "🚦 Trouble toggle" },
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
    e = { ":Telescope file_browser<CR>", "🗃️ Telescope File Browser" },
    E = { ":Explore<CR>", "📂 File Explorer" },
    t = {
      name = " 🔭 Telescope",
      p = { function() require'telescope'.extensions.project.project{} end, "🏗️ Projects"},
      t = { ":Telescope<CR>", "🔭 telescope" },
      o = { ":Telescope fd hidden=true<CR>", "📜 find files" },
      O = { ":Telescope oldfiles<CR>", "👴 old files" },
      q = { ":Telescope quickfix<CR>", "🛠️ quickfix" },
      r = { ":Telescope registers<CR>", "®️ registers" },
      f = { ":Telescope current_buffer_fuzzy_find<CR>", "📃 find in current file" },
      F = { M.searchForWordUnderCursor, "👇 Search for word under cursor" },
      s = { ":Telescope live_grep<CR>", "🐚 live grep" },
      b = { ":Telescope buffers<CR>", "🗃️ search buffers" },
      d = { ":Telescope diagnostics<CR>", "⚠️  View diagnostics" },
      v = {
        name = "🦙 vim configuration",
        o = { ":Telescope vim_options<CR>", "⚙️  vim options" },
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
      g = { ":lua require('neogen').generate()<CR>", "🧬 Generate documentation" }
    },
    w = {
      name = "🪟 Windows",
      h = { "<C-w>h", "👈 Move left" },
      l = { "<C-w>l", "👉 Move right" },
      j = { "<C-w>j", "👇 Move down" },
      k = { "<C-w>k", "👉 Move up" },
    },
  },
})

