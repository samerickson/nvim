return {
    'shortcuts/no-neck-pain.nvim',
    keys = {
        { '<leader>z', '<cmd>NoNeckPain<cr>', desc = 'No Neck Pain' },
    },
    opts = {
        width = 180,
        buffers = {
            right = { enabled = false },
            wo = {
                fillchars = 'eob: ',
            },
            scratchPad = {
                enabled = true,
                fileName = 'notes',
                location = '~/',
            },
            bo = {
                filetype = 'md',
            },
        },
    },
}
