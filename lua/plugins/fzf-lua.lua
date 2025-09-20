return {
    'ibhagwan/fzf-lua',
    dependencies = { 'echasnovski/mini.icons' },
    cmd = { 'Fzflua' },
    keys = {
        { '<leader>k', '<cmd>FzfLua global<Cr>', desc = 'Find' },
        { '<leader>fd', '<cmd>FzfLua lsp_document_diagnostics<cr>', desc = 'Document diagnostics' },
        { '<leader>fg', '<cmd>FzfLua live_grep<cr>', desc = 'Grep' },
        { '<leader>fr', '<cmd>FzfLua registers<cr>', desc = 'Registers' },
        { '<leader>p', '<cmd>FzfLua registers<cr>', desc = 'Registers' },
        { '<leader>fa', '<cmd>FzfLua<cr>', desc = 'Fzflua' },
        { '<leader>fl', '<cmd>FzfLua resume<cr>', desc = 'Resume last fzf command' },
        { '<leader>ff', '<cmd>FzfLua files<cr>', desc = 'Find files' },
        { '<leader>fr', '<cmd>FzfLua oldfiles<cr>', desc = 'Recently opened files' },
        { '<leader>/', '<cmd>FzfLua live_grep<cr>', desc = 'Grep' },
        { '<leader>fg', '<cmd>FzfLua grep_visual<cr>', desc = 'Grep', mode = 'x' },
        { '<leader>fz', '<cmd>FzfLua zoxide<cr>', desc = 'Zoxide' },
        { '<leader>fh', '<cmd>FzfLua helptags<cr>', desc = 'Zoxide' },
        { 'z=', '<cmd>FzfLua spell_suggest<cr>', desc = 'Spelling suggestions' },
        -- Git
        { '<leader>gb', '<cmd>FzfLua git_blame<cr>', desc = 'Blame' },
        { '<leader>gB', '<cmd>FzfLua git_branches<cr>', desc = 'Branches' },
        { '<leader>gc', '<cmd>FzfLua git_commits<cr>', desc = 'Commits' },
        { '<leader>gd', '<cmd>FzfLua git_diff<cr>', desc = 'Diff' },
        { '<leader>gs', '<cmd>FzfLua git_status<cr>', desc = 'Status' },
        { '<leader>gS', '<cmd>FzfLua git_stash<cr>', desc = 'Stash' },
        -- Search
        { '<leader>sa', '<cmd>FzfLua<cr>', desc = 'Fzflua' },
        { '<leader>sk', '<cmd>FzfLua keymaps<cr>', desc = 'Keymaps' },
        { '<leader>sl', '<cmd>FzfLua resume<cr>', desc = 'Resume last fzf command' },
        { '<leader>sh', '<cmd>FzfLua search_history<cr>', desc = 'History' },
        { '<C-f>', '<cmd>FzfLua grep_curbuf<cr>', desc = 'Search current buffer' },
    },
    opts = function()
        local actions = require 'fzf-lua.actions'
        vim.api.nvim_create_autocmd('LspAttach', {
            callback = function(event)
                local map = function(keys, func, desc, mode)
                    mode = mode or 'n'
                    vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = desc, remap = true })
                end

                map('gd', '<cmd>FzfLua lsp_implementations<cr>', 'Goto Definition')
                map('<leader>sS', '<cmd>FzfLua lsp_workspace_symbols<cr>', 'Lsp Workshpace Symbols')
                map('<leader>ss', '<cmd>FzfLua lsp_document_symbols<cr>', 'Lsp Document Symbols')
                map('gd', '<cmd>FzfLua lsp_definitions<cr>', 'Goto Definition')
                map('gD', '<cmd>FzfLua lsp_document_diagnostics<cr>', 'Document diagnostics')
                map('ge', '<cmd>FzfLua lsp_workspace<cr>', 'Workspace diagnostics')
                map('gr', '<cmd>FzfLua lsp_references<cr>', 'References')
                map('<leader>ca', '<cmd>FzfLua lsp_code_actions<cr>', 'Code Actions')
                map('gy', '<cmd>FzfLua lsp_typedefs<cr>', 'Goto Type Definition')
                map('gD', '<cmd>FzfLua lsp_declarations<cr>', 'Goto Declaration')
                map('gI', '<cmd>FzfLua lsp_implementations<cr>', 'Goto Implementation')
            end,
        })

        return {
            { 'border-fused', 'hide' },
            -- Make stuff better combine with the editor.
            fzf_colors = {
                bg = { 'bg', 'Normal' },
                gutter = { 'bg', 'Normal' },
                info = { 'fg', 'Conditional' },
                scrollbar = { 'bg', 'Normal' },
                separator = { 'fg', 'Comment' },
            },
            fzf_opts = {
                ['--info'] = 'default',
                ['--layout'] = 'reverse-list',
            },
            keymap = {
                builtin = {
                    ['<C-h>'] = 'toggle-help',
                    ['<C-a>'] = 'toggle-fullscreen',
                    ['<C-i>'] = 'toggle-preview',
                },
                fzf = {
                    ['alt-s'] = 'toggle',
                    ['alt-a'] = 'toggle-all',
                    ['ctrl-i'] = 'toggle-preview',
                },
            },
            winopts = {
                height = 0.7,
                width = 0.6,
                preview = {
                    scrollbar = false,
                },
            },
            defaults = { git_icons = false },
            -- Configuration for specific commands.
            files = {
                winopts = {
                    preview = {
                        hidden = true,
                        layout = 'vertical',
                        vertical = 'up:40%',
                    },
                    width = 0.4,
                },
            },
            grep = {
                rg_glob_fn = function(query, opts)
                    local regex, flags = query:match(string.format('^(.*)%s(.*)$', opts.glob_separator))
                    -- Return the original query if there's no separator.
                    return (regex or query), flags
                end,
                winopts = {
                    preview = {
                        layout = 'horizontal',
                    },
                    col = 0.6,
                },
            },
            helptags = {
                actions = {
                    -- Open help pages in a vertical split.
                    ['enter'] = actions.help_vert,
                },
            },
            oldfiles = {
                include_current_session = true,
                winopts = {
                    preview = {
                        hidden = true,
                        layout = 'vertical',
                        vertical = 'up:40%',
                    },
                },
            },
        }
    end,
}
