vim.pack.add {
    { src = 'https://github.com/ibhagwan/fzf-lua' },
}

local actions = require 'fzf-lua.actions'

local fzf = require 'fzf-lua'

fzf.setup {
    grep = {
        hidden = true,
    },
    helptags = {
        actions = {
            -- Open help pages in a vertical split.
            ['enter'] = actions.help_vert,
        },
    },
    oldfiles = {
        include_current_session = true,
    },
}

-- Search available pickers
vim.keymap.set('n', '<leader>fp', '<cmd>FzfLua<cr>', { desc = 'Pickers' })

-- Resume
vim.keymap.set('n', '<leader>f<', '<cmd>FzfLua resume<cr>', { desc = 'Resume last fzf command' })

-- Buffers and files
vim.keymap.set('n', '<leader>fb', '<cmd>FzfLua buffers<cr>', { desc = 'Buffers' })
vim.keymap.set('n', '<leader>ff', '<cmd>FzfLua files<cr>', { desc = 'Find files' })
vim.keymap.set('n', '<leader>fh', '<cmd>FzfLua history<cr>', { desc = 'History' })
vim.keymap.set('n', '<leader>fr', '<cmd>FzfLua oldfiles<cr>', { desc = 'Recently opened files' })
vim.keymap.set('n', '<leader>fL', '<cmd>FzfLua loclist<cr>', { desc = 'Location list' })
vim.keymap.set('n', '<leader>fl', '<cmd>FzfLua blines<cr>', { desc = 'Lines in buffer' })
vim.keymap.set('n', '<leader>fc', function()
    fzf.git_files {
        cwd = vim.fn.stdpath 'config',
    }
end, { desc = 'Configuration Files' })

-- Search
vim.keymap.set('n', '<leader>sg', '<cmd>FzfLua grep<cr>', { desc = 'Grep' })
vim.keymap.set('n', '<leader>sp', '<cmd>FzfLua grep_project<cr>', { desc = 'Grep project' })
vim.keymap.set('n', '<leader>/', '<cmd>FzfLua live_grep<cr>', { desc = 'Live grep' })
vim.keymap.set('n', '<leader>sh', '<cmd>FzfLua help_tags<cr>', { desc = 'Help' })

-- Git
vim.keymap.set('n', '<leader>gs', '<cmd>FzfLua git_status<cr>', { desc = 'Status' })
vim.keymap.set('n', '<leader>gS', '<cmd>FzfLua git_stash<cr>', { desc = 'Stash' })
vim.keymap.set('n', '<leader>gh', '<cmd>FzfLua git_hunks<cr>', { desc = 'Hunks' })
vim.keymap.set('n', '<leader>gr', '<cmd>FzfLua git_reflog<cr>', { desc = 'Reflog' })
vim.keymap.set('n', '<leader>gc', '<cmd>FzfLua git_commits<cr>', { desc = 'Commits' })
vim.keymap.set('n', '<leader>gl', '<cmd>FzfLua git_commits<cr>', { desc = 'Commits' })
vim.keymap.set('n', '<leader>gC', '<cmd>FzfLua git_bcommits<cr>', { desc = 'Buffer commits' })
vim.keymap.set('n', '<leader>gL', '<cmd>FzfLua git_bcommits<cr>', { desc = 'Buffer commits' })
vim.keymap.set('n', '<leader>gb', '<cmd>FzfLua git_blame<cr>', { desc = 'Blame' })
vim.keymap.set('n', '<leader>gB', '<cmd>FzfLua git_branches<cr>', { desc = 'Branches' })
vim.keymap.set('n', '<leader>gw', '<cmd>FzfLua git_worktrees<cr>', { desc = 'Worktrees' })

-- LSP
vim.keymap.set('n', '<leader>fd', '<cmd>FzfLua lsp_document_diagnostics<cr>', { desc = 'Document diagnostics' })
vim.keymap.set('n', 'gd', '<cmd>FzfLua lsp_definitions<cr>', { desc = 'LSP Definitions' })
vim.keymap.set('n', 'gD', '<cmd>FzfLua lsp_declarations<cr>', { desc = 'LSP Declarations' })
vim.keymap.set('n', 'gr', '<cmd>FzfLua lsp_references<cr>', { desc = 'LSP References' })
vim.keymap.set('n', 'gI', '<cmd>FzfLua lsp_incoming_calls<cr>', { desc = 'LSP Incomming calls' })
vim.keymap.set('n', 'gO', '<cmd>FzfLua lsp_outgoing_calls<cr>', { desc = 'LSP Outgoing calls' })

-- Misc
vim.keymap.set('n', '<leader>sm', '<cmd>FzfLua manpages<cr>', { desc = 'Manpages' })
vim.keymap.set('n', '<leader>sH', '<cmd>FzfLua highlights<cr>', { desc = 'Highlights' })
vim.keymap.set('n', '<leader>sC', '<cmd>FzfLua colorschemes<cr>', { desc = 'Highlights' })
vim.keymap.set('n', '<leader>sr', '<cmd>FzfLua registers<cr>', { desc = 'Registers' })
vim.keymap.set('n', '<leader>sk', '<cmd>FzfLua keymaps<cr>', { desc = 'Keymaps' })
vim.keymap.set('n', '<leader>su', '<cmd>FzfLua undotree<cr>', { desc = 'Undotree' })
vim.keymap.set('n', '<leader>sz', '<cmd>FzfLua zoxide<cr>', { desc = 'Zoxide' })

-- Overrides
vim.keymap.set('n', 'z=', '<cmd>FzfLua spell_suggest<cr>', { desc = 'Spelling suggestions' })
vim.keymap.set('i', '<C-x><C-f>', function()
    require('fzf-lua').complete_path {
        winopts = {
            height = 0.4,
            width = 0.5,
            relative = 'cursor',
        },
    }
end, { desc = 'Fuzzy complete path' })
