return {
    {
        'mason-org/mason.nvim',
        event = 'UIEnter',
        opts = {},
    },
    {
        -- Main LSP Configuration
        'neovim/nvim-lspconfig',
        event = { 'BufReadPre', 'BufNewFile' },
        cmd = { 'LspInfo', 'LspInstall', 'LspUninstall' },
        dependencies = {
            -- Automatically install LSPs and related tools to stdpath for Neovim
            -- Mason must be loaded before its dependents so we need to set it up here.
            -- NOTE: `opts = {}` is the same as calling `require('mason').setup({})`
            { 'mason-org/mason.nvim', opts = {} },
            'mason-org/mason-lspconfig.nvim',
            'WhoIsSethDaniel/mason-tool-installer.nvim',

            'samerickson/snacks.nvim',

            -- Useful status updates for LSP.
            { 'j-hui/fidget.nvim', opts = {} },

            -- Allows extra capabilities provided by blink.cmp
            'saghen/blink.cmp',
        },
        config = function()
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
                callback = function(event)
                    local map = function(keys, func, desc, mode)
                        mode = mode or 'n'
                        vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = desc })
                    end

                    map('gd', function()
                        Snacks.picker.lsp_definitions()
                    end, 'Goto Definition')

                    map('gD', function()
                        Snacks.picker.lsp_declarations()
                    end, 'Goto Declaration')

                    map('gr', function()
                        Snacks.picker.lsp_references()
                    end, 'References')

                    map('gI', function()
                        Snacks.picker.lsp_implementations()
                    end, 'Goto Implementation')

                    map('gy', function()
                        Snacks.picker.lsp_implementations()
                    end, 'Goto T[y]pe definition')

                    map('<leader>ss', function()
                        Snacks.picker.lsp_implementations()
                    end, 'LSP Symbols')

                    map('<leader>sS', function()
                        Snacks.picker.lsp_workspace_symbols()
                    end, 'LSP Workspace Symbols')

                    -- Rename the variable under your cursor.
                    --  Most Language Servers support renaming across files, etc.
                    map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
                    map('<leader>cr', vim.lsp.buf.rename, 'Rename')

                    map('<leader>co', function()
                        vim.lsp.buf.execute_command {
                            command = 'typescript.organizeImports',
                            arguments = { vim.api.nvim_buf_get_name(0) }, -- current file path
                        }
                    end, 'Organize Imports')

                    map('<leader>cM', function()
                        vim.lsp.buf.execute_command {
                            command = 'typescript.addMissingImports',
                            arguments = { vim.api.nvim_buf_get_name(0) }, -- current file path
                        }
                    end, 'Add missing imports')

                    map('<leader>cu', function()
                        vim.lsp.buf.execute_command {
                            command = 'typescript.removeUnused',
                            arguments = { vim.api.nvim_buf_get_name(0) }, -- current file path
                        }
                    end, 'Remove unused imports')

                    map('<leader>cD', function()
                        vim.lsp.buf.execute_command {
                            command = 'typescript.fixAll',
                            arguments = { vim.api.nvim_buf_get_name(0) }, -- current file path
                        }
                    end, 'Fix all diagnostics')

                    local client = vim.lsp.get_client_by_id(event.data.client_id)

                    -- Sets a key mapping just for a specific language server
                    if client and client.name == 'vtsls' then
                        map('<leader>cV', function()
                            client:exec_cmd {
                                title = 'Select TS workspace version',
                                command = 'typescript.selectTypeScriptVersion',
                            }
                        end, 'Select TS workspace version')
                    end

                    -- The following two autocommands are used to highlight references of the
                    -- word under your cursor when your cursor rests there for a little while.
                    --    See `:help CursorHold` for information about when this is executed
                    --
                    -- When you move your cursor, the highlights will be cleared (the second autocommand).
                    if
                        client
                        and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf)
                    then
                        local highlight_augroup =
                            vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
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
                            group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
                            callback = function(event2)
                                vim.lsp.buf.clear_references()
                                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
                            end,
                        })
                    end

                    -- The following code creates a keymap to toggle inlay hints in your
                    -- code, if the language server you are using supports them
                    --
                    -- This may be unwanted, since they displace some of your code
                    if
                        client
                        and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf)
                    then
                        map('<leader>ch', function()
                            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
                        end, '[T]oggle Inlay [H]ints')
                    end

                    if
                        client
                        and client:supports_method(vim.lsp.protocol.Methods.textDocument_signatureHelp, event.buf)
                    then
                        map('<C-s>', function()
                            return vim.lsp.buf.signature_help()
                        end, 'Signature Help', 'i')

                        map('<C-k>', function()
                            return vim.lsp.buf.signature_help()
                        end, 'Signature Help', { 'i', 'n' })
                    end
                end,
            })

            -- Diagnostic Config
            -- See :help vim.diagnostic.Opts
            vim.diagnostic.config {
                severity_sort = true,
                float = { border = 'rounded', source = 'if_many' },
                underline = { severity = vim.diagnostic.severity.ERROR },
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

            -- The servers table comprises of the following sub-tables:
            -- 1. mason
            -- 2. others
            -- Both these tables have an identical structure of language server names as keys and
            -- a table of language server configuration as values.
            ---@class LspServersConfig
            ---@field mason table<string, vim.lsp.Config>
            ---@field others table<string, vim.lsp.Config>
            local servers = {
                mason = {
                    clangd = {},
                    gopls = {},
                    -- pyright = {},
                    -- rust_analyzer = {},
                    -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
                    --
                    -- Some languages (like typescript) have entire language plugins that can be useful:
                    --    https://github.com/pmizio/typescript-tools.nvim
                    --
                    -- But for many setups, the LSP (`ts_ls`) will work just fine
                    -- ts_ls = {},
                    --
                    vtsls = {
                        filetypes = {
                            'javascript',
                            'javascriptreact',
                            'javascript.jsx',
                            'typescript',
                            'typescriptreact',
                            'typescript.tsx',
                            'vue',
                        },
                        settings = {
                            complete_function_calls = true,
                            vtsls = {
                                enableMoveToFileCodeAction = true,
                                autoUseWorkspaceTsdk = true,
                                experimental = {
                                    maxInlayHintLength = 30,
                                    completion = {
                                        enableServerSideFuzzyMatch = true,
                                    },
                                },
                            },
                            typescript = {
                                updateImportsOnFileMove = { enabled = 'always' },
                                suggest = {
                                    completeFunctionCalls = true,
                                },
                                inlayHints = {
                                    enumMemberValues = { enabled = true },
                                    functionLikeReturnTypes = { enabled = true },
                                    parameterNames = { enabled = 'literals' },
                                    parameterTypes = { enabled = true },
                                    propertyDeclarationTypes = { enabled = true },
                                    variableTypes = { enabled = false },
                                },
                            },
                        },
                    },

                    lua_ls = {
                        -- cmd = { ... },
                        -- filetypes = { ... },
                        -- capabilities = {},
                        settings = {
                            Lua = {
                                completion = {
                                    callSnippet = 'Replace',
                                },
                                -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
                                -- diagnostics = { disable = { 'missing-fields' } },
                            },
                        },
                    },
                },
                others = {
                    -- dartls = {},
                },
            }

            local ensure_installed = vim.tbl_keys(servers.mason or {})
            vim.list_extend(ensure_installed, {
                'stylua', -- Used to format Lua code
            })
            require('mason-tool-installer').setup { ensure_installed = ensure_installed }

            -- Either merge all additional server configs from the `servers.mason` and `servers.others` tables
            -- to the default language server configs as provided by nvim-lspconfig or
            -- define a custom server config that's unavailable on nvim-lspconfig.
            for server, config in pairs(vim.tbl_extend('keep', servers.mason, servers.others)) do
                if not vim.tbl_isempty(config) then
                    vim.lsp.config(server, config)
                end
            end

            require('mason-lspconfig').setup {
                ensure_installed = {}, -- explicitly set to an empty table (Kickstart populates installs via mason-tool-installer)
                automatic_enable = true, -- automatically run vim.lsp.enable() for all servers that are installed via Mason
            }

            -- Manually run vim.lsp.enable for all language servers that are *not* installed via Mason
            if not vim.tbl_isempty(servers.others) then
                vim.lsp.enable(vim.tbl_keys(servers.others))
            end
        end,
    },
}
