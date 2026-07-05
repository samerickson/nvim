local notes_dir = vim.fn.expand '~/notes'

local function split_lines(s)
    local t = {}
    for line in s:gmatch '([^\n]+)' do
        table.insert(t, line)
    end
    return t
end

local function next_business_day()
    local t = os.date '*t'

    local function add_days(days)
        t.day = t.day + days
        return os.time(t)
    end

    local wday = t.wday -- 1=Sun ... 7=Sat

    if wday == 6 then -- Friday
        return os.date('%F', add_days(3))
    elseif wday == 7 then -- Saturday
        return os.date('%F', add_days(2))
    else
        return os.date('%F', add_days(1))
    end
end

local function handle_daily_picker()
    local cwd = notes_dir .. '/daily'

    local result = vim.system({
        'fd',
        '.',
        cwd,
        '--exec',
        'realpath',
        '--relative-to=' .. cwd,
        '{}',
    }):wait(50)

    local files = split_lines(result.stdout)
    local next_business_day_file = cwd .. '/' .. next_business_day() .. '.md'
    local today_file = cwd .. '/' .. os.date '%F' .. '.md'
    local yesterday = cwd .. '/' .. os.date('%F', os.time() - 86400) .. '.md'

    local format_label = function(path, label)
        local stat = vim.uv.fs_stat(path)

        if stat and stat.type == 'file' then
            return label
        end

        return ' ' .. label
    end

    local run_daily_note = function(period)
        local r = vim.system({ 'note', 'daily', 'date', period }):wait(500)

        if r ~= nil and r.code ~= 0 then
            vim.notify(r.stderr, vim.log.levels.ERROR)
        end
    end

    local daily_item = function(path, label)
        local filename = vim.fn.fnamemodify(path, ':t:r')
        return {
            label = format_label(path, label),
            note_action = filename,
            -- If the note does not exist yet, leave `file` nil so confirm can create it.
            file = path ~= '' and path or nil,
        }
    end

    local items = {
        daily_item(today_file, 'today'),
        daily_item(next_business_day_file, 'next business day'),
        daily_item(yesterday, 'yesterday'),
    }

    -- TODO filter out items that match the above files if they exist

    local seen = {}

    for _, item in ipairs(items) do
        local filename = vim.fn.fnamemodify(item.file, ':t')
        seen[filename] = true
    end

    for _, f in ipairs(files) do
        if not seen[f] then
            table.insert(items, { file = f, cwd = cwd })
        end
    end

    Snacks.picker {
        items = items,

        confirm = function(picker, item, action)
            if item ~= nil and item.note_action ~= nil then
                picker:close()
                run_daily_note(item.note_action)
                return
            end

            require('snacks.picker.actions').confirm(picker, item, action)
        end,
    }
end

local function daily(day)
    local mday = day
    if day == nil then
        mday = 'today'
    end

    local result = vim.system({ 'note', 'daily', mday }):wait(500)

    if result ~= nil and result.code ~= 0 then
        vim.notify(result.stderr, vim.log.levels.ERROR)
    end
end

local function new_note(note_name)
    local result = vim.system({ 'note', 'new', note_name }):wait(500)

    if result ~= nil and result.code ~= 0 then
        vim.notify(result.stderr, vim.log.levels.ERROR)
    end
end

vim.keymap.set('n', '<leader>nt', function()
    daily()
end, { desc = 'Todays note' })

vim.keymap.set('n', '<leader>nT', function()
    daily 'next'
end, { desc = 'Next business day note' })

vim.keymap.set('n', '<leader>nn', function()
    Snacks.input.input({ prompt = 'File name: ' }, function(file_name)
        new_note(file_name)
    end)
end, { desc = 'New note' })

vim.keymap.set('n', '<leader>ne', function()
    Snacks.picker.explorer { cwd = notes_dir }
end, { desc = 'Explore notes' })

vim.keymap.set('n', '<leader>nf', function()
    Snacks.picker.files { cwd = notes_dir }
end, { desc = 'Find file' })

vim.keymap.set('n', '<leader>nd', handle_daily_picker, { desc = 'Search Daily Files' })
