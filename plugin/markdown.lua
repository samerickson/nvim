local pack = require 'samerickson.pack'
local gh = pack.gh

vim.pack.add {
    gh 'folke/snacks.nvim',
    gh 'selimacerbas/live-server.nvim',
    gh 'selimacerbas/markdown-preview.nvim',
    gh 'MeanderingProgrammer/render-markdown.nvim',
    gh 'HakonHarnes/img-clip.nvim',
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

Snacks.toggle({
    name = 'Render Markdown',
    get = function()
        return require('render-markdown.state').enabled
    end,
    set = function(enabled)
        local m = require 'render-markdown'
        if enabled then
            m.enable()
        else
            m.disable()
        end
    end,
}):map '<leader>um'

vim.keymap.set('i', '<c-p>', '<cmd>PasteImage<cr>', { desc = 'Paste Image' })

vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'markdown' },
    callback = function()
        vim.opt_local.conceallevel = 2
    end,
})
