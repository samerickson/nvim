---@module 'lazy'
---@type LazySpec
return {
    {
        'nvim-treesitter/nvim-treesitter-textobjects',
        branch = 'main',
    },
    {
        'nvim-treesitter/nvim-treesitter',
        cmd = { 'TSUpdate', 'TSInstall', 'TSLog', 'TSUninstall' },
        build = ':TSUpdate',
        branch = 'main',
        opts = {
            ensure_installed = {
                'bash',
                'c',
                'cpp',
                'css',
                'fish',
                'gitcommit',
                'graphql',
                'help',
                'html',
                'java',
                'javascript',
                'json',
                'json5',
                'jsonc',
                'lua',
                'markdown',
                'markdown_inline',
                'python',
                'query',
                'rasi',
                'regex',
                'rust',
                'scss',
                'toml',
                'tsx',
                'typescript',
                'vim',
                'vimdoc',
                'vue',
                'yaml',
            },
            highlight = { enable = true },
            indent = {
                enable = true,
                -- Treesitter unindents Yaml lists for some reason.
                disable = { 'yaml' },
            },
        },
        config = function(_, opts)
            vim.api.nvim_create_autocmd('FileType', {
                callback = function(args)
                    local bufnr = args.buf
                    local ft = vim.bo[bufnr].filetype

                    local language = vim.treesitter.language.get_lang(ft)
                    if not language then
                        return
                    end

                    if not vim.treesitter.language.add(language) then
                        return
                    end

                    vim.treesitter.start(bufnr, ft)

                    -- enables treesitter based indentation
                    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                end,
            })
        end,
    },
}
