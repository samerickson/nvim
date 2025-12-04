vim.pack.add({
    { src= "https://github.com/rebelot/kanagawa.nvim"}
})

require('kanagawa').setup({
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
    overrides = function(colors) -- add/modify highlights
        local theme = colors.theme
        local highlights = {
            NormalFloat = { bg = 'none' },
            FloatBorder = { bg = 'none' },
            FloatTitle = { bg = 'none' },

            -- SnacksDashboard
            SnacksDashboardHeader = { fg = theme.vcs.removed },
            SnacksDashboardFooter = { fg = theme.syn.comment },
            SnacksDashboardDesc = { fg = theme.syn.identifier },
            SnacksDashboardIcon = { fg = theme.ui.special },
            SnacksDashboardKey = { fg = theme.syn.special1 },
            SnacksDashboardSpecial = { fg = theme.syn.comment },
            SnacksDashboardDir = { fg = theme.syn.identifier },
            -- SnacksProfiler
            SnacksProfilerIconInfo = { bg = theme.ui.bg_search, fg = theme.syn.fun },
            SnacksProfilerBadgeInfo = { bg = theme.ui.bg_visual, fg = theme.syn.fun },
            SnacksScratchKey = { link = 'SnacksProfilerIconInfo' },
            SnacksScratchDesc = { link = 'SnacksProfilerBadgeInfo' },
            SnacksProfilerIconTrace = { bg = theme.syn.fun, fg = theme.ui.float.fg_border },
            SnacksProfilerBadgeTrace = { bg = theme.syn.fun, fg = theme.ui.float.fg_border },
            SnacksIndent = { fg = theme.ui.bg_p2, nocombine = true },
            SnacksIndentScope = { fg = theme.ui.pmenu.bg, nocombine = true },
            SnacksZenIcon = { fg = theme.syn.statement },
            SnacksInputIcon = { fg = theme.ui.pmenu.bg },
            SnacksInputBorder = { fg = theme.syn.identifier },
            SnacksInputTitle = { fg = theme.syn.identifier },
            -- SnacksPicker
            SnacksPickerInputBorder = { fg = theme.syn.constant },
            SnacksPickerInputTitle = { fg = theme.syn.constant },
            SnacksPickerBoxTitle = { fg = theme.syn.constant },
            SnacksPickerSelected = { fg = theme.syn.number },
            SnacksPickerToggle = { link = 'SnacksProfilerBadgeInfo' },
            SnacksPickerPickWinCurrent = { fg = theme.ui.fg, bg = theme.syn.number, bold = true },
            SnacksPickerPickWin = { fg = theme.ui.fg, bg = theme.ui.bg_search, bold = true },
            SnacksPickerTree = { bg = 'none' },

            -- Save an hlgroup with dark background and dimmed foreground
            -- so that you can use it where your still want darker windows.
            -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
            NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

            -- Popular plugins that open floats will link to NormalFloat by default;
            -- set their background accordingly if you wish to keep them dark and borderless
            LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
            MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
        }

        -- SnacksNotifier
        local notifier_links = {
            { suffix = 'Error', target = 'DiagnosticError' },
            { suffix = 'Warn', target = 'DiagnosticWarn' },
            { suffix = 'Info', target = 'DiagnosticInfo' },
            { suffix = 'Debug', target = 'Debug' },
            { suffix = 'Trace', target = 'Comment' },
        }

        for _, link in ipairs(notifier_links) do
            highlights['SnacksNotifierBorder' .. link.suffix] = { link = link.target }
            highlights['SnacksNotifierIcon' .. link.suffix] = { link = link.target }
            highlights['SnacksNotifierTitle' .. link.suffix] = { link = link.target }
            highlights['SnacksNotifier' .. link.suffix] = { link = link.target }
        end

        return highlights
    end,
    theme = 'wave',
    background = {
        dark = 'wave',
        light = 'lotus',
    },
})

vim.cmd("colorscheme kanagawa")
