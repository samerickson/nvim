local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'

if not vim.uv or vim.loop.fs_stat(lazypath) then
    -- stylua: ignore
    vim.fn.system({ 'git', 'clone', '--filter=blob:none', 'https://github.com/folke/lazy.nvim.git', '--branch=stable', lazypath })
end

vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require 'options'
require 'keymaps'

require('lazy').setup {
    spec = {
        { import = 'plugins' },
    },
    defaults = {
        lazy = true,
        version = false,
    },
    install = {
        missing = true,
        colorscheme = { 'kanagawa', 'habamax' },
    },
    checker = { enabled = false },
    change_detection = {
        notify = false,
    },
    dev = {
        path = '~/dev/nvim-plugins',
        patterns = { 'samerickson' },
        fallback = true,
    },
    performance = {
        cache = { enabled = true },
        reset_packpath = true,
        rtp = {
            disabled_plugins = {
                '2html_plugin',
                'gzip',
                'matchit',
                'matchparen',
                'netrwPlugin',
                'netrwSettings',
                'netrwFileHandlers',
                'tarPlugin',
                'tohtml',
                'tutor',
                'zipPlugin',
            },
        },
    },
}
