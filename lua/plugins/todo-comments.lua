return {
    {
        'folke/todo-comments.nvim',
        event = 'VimEnter',
        dependencies = { 'nvim-lua/plenary.nvim' },
        ---@module 'todo-comments'
        ---@diagnostic disable-next-line: missing-fields
        opts = { signs = false },
    },
}
