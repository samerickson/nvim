local pack = require 'samerickson.pack'
local gh = pack.gh

vim.pack.add {
    gh 'folke/snacks.nvim',
    gh 'iamcco/markdown-preview.nvim',
    gh 'MeanderingProgrammer/render-markdown.nvim',
    gh 'HakonHarnes/img-clip.nvim',
}

pack.on_plugin_update('markdown-preview', function()
    vim.fn['mkdp#util#install']()
end)

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
