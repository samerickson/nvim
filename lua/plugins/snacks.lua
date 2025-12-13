vim.pack.add {
    { src = 'https://github.com/folke/snacks.nvim' },
}

require('snacks').setup {
    bigfile = { enabled = true },
    dashboard = { enabled = false },
    explorer = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    picker = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = false },
}

local map = vim.keymap.set
local pick = Snacks.picker
-- stylua: ignore start

-- Top Pickers & Explorer
map('n', '<leader><space>', function() pick.smart() end, { desc = 'Smart Find Files' })
map('n', '<leader>,', function() pick.buffers() end, { desc = 'Buffers' })
map('n', '<leader>/', function() pick.grep() end, { desc = 'Grep' })
map('n', '<leader>:', function() pick.command_history() end, { desc = 'Command History' })
map('n', '<leader>n', function() pick.notifications() end, { desc = 'Notification History' })
map('n', '<leader>e', function() Snacks.explorer() end, { desc = 'File Explorer' })

-- find
map('n', '<leader>fb', function() pick.buffers() end, { desc = 'Buffers' })
map('n', '<leader>fc', function() pick.files { cwd = vim.fn.stdpath 'config' } end, { desc = 'Find Config File' })
map('n', '<leader>ff', function() pick.files() end, { desc = 'Find Files' })
map('n', '<leader>fg', function() pick.git_files() end, { desc = 'Find Git Files' })
map('n', '<leader>fp', function() pick.projects() end, { desc = 'Projects' })
map('n', '<leader>fr', function() pick.recent() end, { desc = 'Recent' })

-- git
map('n', '<leader>gb', function() pick.git_branches() end, { desc = 'Git Branches' })
map('n', '<leader>gl', function() pick.git_log() end, { desc = 'Git Log' })
map('n', '<leader>gL', function() pick.git_log_line() end, { desc = 'Git Log Line' })
map('n', '<leader>gs', function() pick.git_status() end, { desc = 'Git Status' })
map('n', '<leader>gS', function() pick.git_stash() end, { desc = 'Git Stash' })
map('n', '<leader>gd', function() pick.git_diff() end, { desc = 'Git Diff (Hunks)' })
map('n', '<leader>gf', function() pick.git_log_file() end, { desc = 'Git Log File' })

-- Grep
map('n', '<leader>sb', function() pick.lines() end, { desc = 'Buffer Lines' })
map('n', '<leader>sB', function() pick.grep_buffers() end, { desc = 'Grep Open Buffers' })
map('n', '<leader>sg', function() pick.grep() end, { desc = 'Grep' })
map({ 'n', 'x' }, '<leader>sw', function() pick.grep_word() end, { desc = 'Visual selection or word' })

-- search
map('n', '<leader>s"', function() pick.registers() end, { desc = 'Registers' })
map('n', '<leader>s/', function() pick.search_history() end, { desc = 'Search History' })
map('n', '<leader>sa', function() pick.autocmds() end, { desc = 'Autocmds' })
map('n', '<leader>sb', function() pick.lines() end, { desc = 'Buffer Lines' })
map('n', '<leader>sc', function() pick.command_history() end, { desc = 'Command History' })
map('n', '<leader>sC', function() pick.commands() end, { desc = 'Commands' })
map('n', '<leader>sd', function() pick.diagnostics() end, { desc = 'Diagnostics' })
map('n', '<leader>sD', function() pick.diagnostics_buffer() end, { desc = 'Buffer Diagnostics' })
map('n', '<leader>sh', function() pick.help() end, { desc = 'Help Pages' })
map('n', '<leader>sH', function() pick.highlights() end, { desc = 'Highlights' })
map('n', '<leader>si', function() pick.icons() end, { desc = 'Icons' })
map('n', '<leader>sj', function() pick.jumps() end, { desc = 'Jumps' })
map('n', '<leader>sk', function() pick.keymaps() end, { desc = 'Keymaps' })
map('n', '<leader>sl', function() pick.loclist() end, { desc = 'Location List' })
map('n', '<leader>sm', function() pick.marks() end, { desc = 'Marks' })
map('n', '<leader>sM', function() pick.man() end, { desc = 'Man Pages' })
map('n', '<leader>sp', function() pick.lazy() end, { desc = 'Search for Plugin Spec' })
map('n', '<leader>sq', function() pick.qflist() end, { desc = 'Quickfix List' })
map('n', '<leader>sR', function() pick.resume() end, { desc = 'Resume' })
map('n', '<leader>su', function() pick.undo() end, { desc = 'Undo History' })
map('n', '<leader>uC', function() pick.colorschemes() end, { desc = 'Colorschemes' })

-- LSP
map('n', 'gd', function() pick.lsp_definitions() end, { desc = 'Goto Definition' })
map('n', 'gD', function() pick.lsp_declarations() end, { desc = 'Goto Declaration' })
map('n', 'gr', function() pick.lsp_references() end, { desc = 'References', nowait = true })
map('n', 'gI', function() pick.lsp_implementations() end, { desc = 'Goto Implementation' })
map('n', 'gy', function() pick.lsp_type_definitions() end, { desc = 'Goto Type Definition' })
map('n', 'gri', function() pick.lsp_incoming_calls() end, { desc = 'Calls Incoming' })
map('n', 'gro', function() pick.lsp_outgoing_calls() end, { desc = 'Calls Outgoing' })
map('n', '<leader>ss', function() pick.lsp_symbols() end, { desc = 'LSP Symbols' })
map('n', '<leader>sS', function() pick.lsp_workspace_symbols() end, { desc = 'LSP Workspace Symbols' })

-- Other
map('n', '<leader>z', function() Snacks.zen() end, { desc = 'Toggle Zen Mode' })
map('n', '<leader>Z', function() Snacks.zen.zoom() end, { desc = 'Toggle Zoom' })
map('n', '<leader>.', function() Snacks.scratch() end, { desc = 'Toggle Scratch Buffer' })
map('n', '<leader>S', function() Snacks.scratch.select() end, { desc = 'Select Scratch Buffer' })
map('n', '<leader>n', function() Snacks.notifier.show_history() end, { desc = 'Notification History' })
map('n', '<leader>bd', function() Snacks.bufdelete() end, { desc = 'Delete Buffer' })
map('n', '<leader>cR', function() Snacks.rename.rename_file() end, { desc = 'Rename File' })
map({ 'n', 'v' }, '<leader>gB', function() Snacks.gitbrowse() end, { desc = 'Git Browse' })
map('n', '<leader>gg', function() Snacks.lazygit() end, { desc = 'Lazygit' })
map('n', '<leader>un', function() Snacks.notifier.hide() end, { desc = 'Dismiss All Notifications' })
map('n', '<c-/>', function() Snacks.terminal() end, { desc = 'Toggle Terminal' })
map('n', '<c-_>', function() Snacks.terminal() end, { desc = 'which_key_ignore' })

map({ 'n', 't' }, ']]', function() Snacks.words.jump(vim.v.count1) end, { desc = 'Next Reference' })
map({ 'n', 't' }, '[[', function() Snacks.words.jump(-vim.v.count1) end, { desc = 'Prev Reference' })

-- stylua: ignore end
