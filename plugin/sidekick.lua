vim.pack.add { 'https://github.com/folke/sidekick.nvim' }

require('sidekick').setup {
    nes = { enabled = false },
    cli = {
        mux = {
            backend = 'tmux',
            enabled = not require('samerickson.utils').is_windows,
        },
    },
}

local map = vim.keymap.set
local cli = require 'sidekick.cli'

map('n', '<leader>as', function()
    cli.select()
end, { desc = 'Sidekick Select CLI' })

map('n', '<leader>ad', function()
    cli.close()
end, { desc = 'Sidekick Close' })

map('n', '<leader>af', function()
    cli.send { msg = '{file}' }
end, { desc = 'Send File' })

map('v', '<leader>av', function()
    cli.send { msg = '{selection}' }
end, { desc = 'Sidekick Send Visual Selection' })

map({ 'n', 'v' }, '<leader>ap', function()
    cli.prompt()
end, { desc = 'Sidekick Select Prompt' })

map({ 'n', 'x', 'i', 't' }, '<A-/>', function()
    if vim.bo.filetype == 'sidekick_terminal' then
        cli.toggle()
    else
        cli.focus { name = 'codex', focus = true }
    end
end, { desc = 'Sidekick Switch Toggle' })
