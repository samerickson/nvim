vim.pack.add {
    'https://github.com/j-hui/fidget.nvim',
    'https://github.com/neovim/nvim-lspconfig',
}
require('fidget').setup {}

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('sam-lsp-attach', { clear = true }),
    callback = function(event)
        local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = desc })
        end

        -- Rename the variable under your cursor.
        --  Most Language Servers support renaming across files, etc.
        map('<leader>rn', vim.lsp.buf.rename, 'Rename')
        map('<leader>cr', vim.lsp.buf.rename, 'Rename')
        map('<leader>ca', vim.lsp.buf.code_action, 'Code Actions')

        local client = vim.lsp.get_client_by_id(event.data.client_id)

        if not client then
            return
        end

        -- Sets a key mapping just for a specific language server
        if client.name == 'vtsls' then
            -- Only set TS-related maps when vtsls attaches, and for TS/JS/Vue files
            local ft = vim.bo[event.buf].filetype
            local allowed_fts = {
                typescript = true,
                javascript = true,
                javascriptreact = true,
                typescriptreact = true,
                vue = true,
            }

            if allowed_fts[ft] then
                local function vtsls_exec(cmd)
                    client:request('workspace/executeCommand', {
                        command = cmd,
                        arguments = { vim.api.nvim_buf_get_name(event.buf) },
                    })
                end

                map('<leader>co', function()
                    vtsls_exec 'typescript.organizeImports'
                end, 'Organize Imports')

                map('<leader>cM', function()
                    vtsls_exec 'typescript.addMissingImports'
                end, 'Add missing imports')

                map('<leader>cu', function()
                    vtsls_exec 'typescript.removeUnused'
                end, 'Remove unused imports')

                map('<leader>cD', function()
                    vtsls_exec 'typescript.fixAll'
                end, 'Fix all diagnostics')
            end
            map('<leader>cV', function()
                client:exec_cmd {
                    title = 'Select TS workspace version',
                    command = 'typescript.selectTypeScriptVersion',
                }
            end, 'Select TS workspace version')
        end

        if client.name == 'eslint' then
            map('<leader>ce', ':LspEslintFixAll<CR>', 'ESLint Fix All')
        end
        -- The following two autocommands are used to highlight references of the
        -- word under your cursor when your cursor rests there for a little while.
        --    See `:help CursorHold` for information about when this is executed
        --
        -- When you move your cursor, the highlights will be cleared (the second autocommand).
        if client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup('sam-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
                group = vim.api.nvim_create_augroup('sam-lsp-detach', { clear = true }),
                callback = function(event2)
                    vim.lsp.buf.clear_references()
                    vim.api.nvim_clear_autocmds { group = highlight_augroup, buffer = event2.buf }
                end,
            })
        end

        if client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            map('<leader>ch', function()
                local enabled = vim.lsp.inlay_hint.is_enabled { bufnr = event.buf }
                vim.lsp.inlay_hint.enable(not enabled, { bufnr = event.buf })
            end, 'Toggle Inlay Hints')
        end

        if client:supports_method(vim.lsp.protocol.Methods.textDocument_signatureHelp, event.buf) then
            map('<C-k>', function()
                return vim.lsp.buf.signature_help()
            end, 'Signature Help', { 'i', 'n' })
        end

        if client:supports_method('textDocument/formatting', event.buf) then
            map('<leader>cf', function()
                vim.lsp.buf.format { async = true }
            end, 'Format buffer', { 'n' })
        end
    end,
})

vim.diagnostic.config {
    severity_sort = true,
    float = { border = 'rounded', source = 'if_many' },
    underline = { severity = { min = vim.diagnostic.severity.HINT } },
    signs = vim.g.have_nerd_font and {
        text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
        },
    } or {},
    virtual_text = {
        source = 'if_many',
        spacing = 2,
        format = function(diagnostic)
            local diagnostic_message = {
                [vim.diagnostic.severity.ERROR] = diagnostic.message,
                [vim.diagnostic.severity.WARN] = diagnostic.message,
                [vim.diagnostic.severity.INFO] = diagnostic.message,
                [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
        end,
    },
}

vim.lsp.config('vtsls', {
    settings = {
        vtsls = {
            tsserver = {
                globalPlugins = {
                    {
                        name = '@vue/typescript-plugin',
                        location = vim.fn.expand '$FNM_MULTISHELL_PATH' .. '/lib/node_modules/@vue/language-server',
                        languages = { 'vue' },
                        configNamespace = 'typescript',
                    },
                },
            },
        },
    },
    filetypes = {
        'javascript',
        'javascriptreact',
        'typescript',
        'typescriptreact',
        'vue',
    },
})

vim.lsp.config('lua_ls', {
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
            },
            diagnostics = {
                globals = { 'vim' },
            },
            workspace = {
                checkThirdParty = false,
                library = vim.api.nvim_get_runtime_file('', true),
            },
            telemetry = {
                enable = false,
            },
        },
    },
})
