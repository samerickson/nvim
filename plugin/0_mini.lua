vim.pack.add {
    'https://github.com/nvim-mini/mini.files',
    'https://github.com/nvim-mini/mini.tabline',
    'https://github.com/echasnovski/mini.icons',
    'https://github.com/nvim-mini/mini.bufremove',
    'https://github.com/nvim-mini/mini.statusline',
    'https://github.com/nvim-mini/mini.statuscolumn',
}

require('mini.icons').setup()
require('mini.tabline').setup()
require('mini.statusline').setup()
require('mini.statuscolumn').setup()

require('mini.files').setup {
    mappings = {
        show_help = '?',
        -- go_in_plus = '<cr>',
        -- go_out_plus = '-',
    },
}

vim.keymap.set('n', '<leader>e', function()
    MiniFiles.open()
end, { desc = 'Mini Files' })

vim.keymap.set('n', '-', function()
    local buf_name = vim.api.nvim_buf_get_name(0)
    local dir = vim.fs.dirname(buf_name)

    MiniFiles.open(dir)
end, { desc = 'Open MiniFiles at current file' })

vim.keymap.set('n', '<leader>bd', function()
    require('mini.bufremove').delete()
end, { desc = 'Mini Files' })

-- Open file under cursor in mini.files in vertical split using <C-v>
vim.api.nvim_create_autocmd('User', {
    pattern = 'MiniFilesBufferCreate',
    callback = function(args)
        local buf_id = args.data.buf_id

        vim.keymap.set('n', '<C-v>', function()
            local cur_target = MiniFiles.get_explorer_state().target_window

            local new_target = vim.api.nvim_win_call(cur_target, function()
                vim.cmd 'belowright vertical split'
                return vim.api.nvim_get_current_win()
            end)

            MiniFiles.set_target_window(new_target)
            MiniFiles.go_in()
        end, {
            buffer = buf_id,
            desc = 'Open in vertical split',
        })
    end,
})
