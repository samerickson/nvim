local notes_dir = vim.fn.expand '~/notes'

---@return string
local function next_business_day()
    local t = (
        os.date '*t' --[[@as osdate]]
    )

    local function add_days(days)
        t.day = t.day + days
        return os.time(t)
    end

    local wday = t.wday -- 1=Sun ... 7=Sat

    if wday == 6 then -- Friday
        return os.date('%F', add_days(3)) --[[@as string]]
    elseif wday == 7 then -- Saturday
        return os.date('%F', add_days(2)) --[[@as string]]
    else
        return os.date('%F', add_days(1)) --[[@as string]]
    end
end

---Handle daily note
---@param day string? day to open in format YYYY-mm-dd
local function daily(day)
    local date = day or os.date '%Y-%m-%d'
    local dir = vim.fn.expand '~/notes/daily'
    local file = dir .. '/' .. date .. '.md'

    vim.fn.mkdir(dir, 'p')

    if vim.fn.filereadable(file) == 0 then
        vim.fn.writefile({
            '# Daily ' .. date,
            '',
        }, file)
    end

    vim.cmd.edit(vim.fn.fnameescape(file))
end

local fzf = require 'fzf-lua'

---Create a new note with a specific filename
---@param name string - name of the note
local function new_note(name)
    vim.cmd.edit(vim.fn.fnameescape(string.format('%s/notes/%s.md', notes_dir, name)))
end

vim.keymap.set('n', '<leader>nt', function()
    daily()
end, { desc = 'Todays note' })

vim.keymap.set('n', '<leader>nT', function()
    daily(next_business_day())
end, { desc = 'Next business day note' })

vim.keymap.set('n', '<leader>nn', function()
    vim.ui.input({ prompt = 'File name: ' }, function(file_name)
        new_note(file_name)
    end)
end, { desc = 'New note' })

vim.keymap.set('n', '<leader>nd', function()
    fzf.files { cwd = notes_dir .. '/daily' }
end, { desc = 'Search Daily Files' })

vim.keymap.set('n', '<leader>nf', function()
    fzf.files { cwd = notes_dir }
end, { desc = 'Search Note Files' })

vim.keymap.set('n', '<leader>ns', function()
    require('fzf-lua').live_grep {
        prompt = 'search notes> ',
        cwd = notes_dir,
        rg_opts = "--column --line-number --no-heading --color=always --hidden --glob '!.git/*'",
    }
end, { desc = 'Search Notes' })
