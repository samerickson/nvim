local pack = require 'samerickson.pack'

vim.pack.add {
    'https://github.com/selimacerbas/live-server.nvim',
    'https://github.com/selimacerbas/markdown-preview.nvim',
    'https://github.com/MeanderingProgrammer/render-markdown.nvim',
}

pack.on_plugin_update('markdown-preview', function()
    vim.fn['mkdp#util#install']()
end)

require('markdown_preview').setup {
    -- all optional; sane defaults shown
    instance_mode = 'takeover', -- "takeover" (one tab) or "multi" (tab per instance)
    port = 0, -- 0 = auto (8421 for takeover, OS-assigned for multi)
    browser = { 'cmd.exe', '/C', 'start', '""', 'firefox' },
    open_browser = true,
    default_theme = 'dark', -- "dark" or "light"; initial preview theme
    debounce_ms = 300,
}

require('render-markdown').setup {
    code = {
        sign = true,
        width = 'block',
        right_pad = 1,
    },
    heading = {
        sign = true,
        icons = {},
    },
    checkbox = {
        enabled = true,
    },
}

vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'markdown' },
    callback = function()
        vim.opt_local.conceallevel = 2
    end,
})
