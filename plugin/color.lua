vim.pack.add { 'https://github.com/rebelot/kanagawa.nvim' }

require('kanagawa').setup {
    compile = true, -- enable compiling the colorscheme
    undercurl = true, -- enable undercurls
    commentStyle = { italic = true },
    functionStyle = {},
    keywordStyle = { italic = true },
    statementStyle = { bold = true },
    typeStyle = {},
    transparent = false, -- do not set background color
    dimInactive = false, -- dim inactive window `:h hl-NormalNC`
    terminalColors = true, -- define vim.g.terminal_color_{0,17}
    colors = { -- add/modify theme and palette colors
        palette = {},
        theme = {
            wave = {},
            lotus = {},
            dragon = {},
            all = {
                ui = {
                    bg_gutter = 'none',
                },
            },
        },
    },
    theme = 'wave',
    background = {
        dark = 'wave',
        light = 'lotus',
    },
}

vim.cmd 'colorscheme kanagawa'

require('samerickson.pack').on_plugin_update('kanagawa', function()
    vim.cmd 'KanagawaCompile'
end)
