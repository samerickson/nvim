vim.pack.add {
    'https://github.com/akinsho/bufferline.nvim',
    'https://github.com/nvim-tree/nvim-web-devicons',
}

require('bufferline').setup {
    options = {
        diagnostics = 'nvim_lsp',
        always_show_bufferline = false,

        offsets = {
            {
                filetype = 'neo-tree',
                text = 'Neo-tree',
                highlight = 'Directory',
                text_align = 'left',
            },
        },
    },
}

vim.keymap.set('n', '<leader>bp', '<Cmd>BufferLineTogglePin<CR>', { desc = 'Toggle Pin' })
vim.keymap.set('n', '<leader>bP', '<Cmd>BufferLineGroupClose ungrouped<CR>', { desc = 'Delete Non-Pinned Buffers' })
vim.keymap.set('n', '<leader>br', '<Cmd>BufferLineCloseRight<CR>', { desc = 'Delete Buffers to the Right' })
vim.keymap.set('n', '<leader>bl', '<Cmd>BufferLineCloseLeft<CR>', { desc = 'Delete Buffers to the Left' })

vim.keymap.set('n', '<S-h>', '<Cmd>BufferLineCyclePrev<CR>', { desc = 'Prev Buffer' })
vim.keymap.set('n', '<S-l>', '<Cmd>BufferLineCycleNext<CR>', { desc = 'Next Buffer' })

vim.keymap.set('n', '[b', '<Cmd>BufferLineCyclePrev<CR>', { desc = 'Prev Buffer' })
vim.keymap.set('n', ']b', '<Cmd>BufferLineCycleNext<CR>', { desc = 'Next Buffer' })

vim.keymap.set('n', '[B', '<Cmd>BufferLineMovePrev<CR>', { desc = 'Move Buffer Prev' })
vim.keymap.set('n', ']B', '<Cmd>BufferLineMoveNext<CR>', { desc = 'Move Buffer Next' })
