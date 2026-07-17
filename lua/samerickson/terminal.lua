local state = {
    floating = {
        buf = -1,
        win = -1,
        source_win = -1,
    },
    lazygit_floating = {
        buf = -1,
        win = -1,
        source_win = -1,
    },
    bottom = {
        buf = -1,
        win = -1,
        source_win = -1,
    },
}

local function create_or_reuse_buffer(opts)
    local buf = nil
    if vim.api.nvim_buf_is_valid(opts.buf) then
        buf = opts.buf
    else
        buf = vim.api.nvim_create_buf(false, true) -- No file, scratch buffer
    end

    -- Persist terminal even if shell exists
    vim.bo[buf].bufhidden = 'hide'

    return buf
end

local function create_floating_window(opts)
    opts = opts or {}
    local width = opts.width or math.floor(vim.o.columns * 0.9)
    local height = opts.height or math.floor(vim.o.lines * 0.9)

    -- Calculate the position to center the window
    local col = math.floor((vim.o.columns - width) / 2)
    local row = math.floor((vim.o.lines - height) / 2)

    -- Define window configuration
    local win_config = {
        relative = 'editor',
        width = width,
        height = height,
        col = col,
        row = row,
        style = 'minimal',
        border = 'rounded',
    }

    local source_win = vim.api.nvim_get_current_win()
    local buf = create_or_reuse_buffer(opts)
    local win = vim.api.nvim_open_win(buf, true, win_config)

    return { win = win, buf = buf, source_win = source_win }
end

local function create_bottom_window(opts)
    opts = opts or {}
    local width = opts.width or vim.o.columns
    local height = opts.height or 18

    -- Define window configuration
    local win_config = {
        width = width,
        height = height,
        split = 'below',
        style = 'minimal',
    }

    local source_win = vim.api.nvim_get_current_win()
    local buf = create_or_reuse_buffer(opts)
    local win = vim.api.nvim_open_win(buf, true, win_config)

    return { buf = buf, win = win, source_win = source_win }
end

local toggle_terminal = function(terminal_state, create_function, opts)
    opts = opts or {}
    if not vim.api.nvim_win_is_valid(terminal_state.win) then
        terminal_state = create_function { buf = terminal_state.buf }

        vim.api.nvim_buf_call(terminal_state.buf, function()
            if vim.bo.buftype ~= 'terminal' then
                if opts.cmd then
                    vim.cmd.terminal(opts.cmd)
                else
                    vim.cmd.terminal()
                end
            end
        end)

        if opts.on_create then
            opts.on_create(terminal_state.buf)
        end

        -- unlist the terminal from buffer list
        vim.api.nvim_set_option_value('buflisted', false, { buf = terminal_state.buf })

        vim.cmd 'startinsert'
        return terminal_state
    else
        vim.api.nvim_win_hide(terminal_state.win)
        terminal_state.win = -1
        return terminal_state
    end
end

local toggle_lazygit_float_terminal = function()
    state.lazygit_floating = toggle_terminal(state.lazygit_floating, create_floating_window, {
        cmd = 'lazygit',
        on_create = function(buf)
            vim.keymap.set({ 'n', 't' }, 'q', function()
                if vim.api.nvim_win_is_valid(state.lazygit_floating.win) then
                    vim.api.nvim_win_hide(state.lazygit_floating.win)
                end
                state.lazygit_floating.win = -1
            end, { buffer = buf })
        end,
    })
end

local toggle_float_terminal = function()
    state.floating = toggle_terminal(state.floating, create_floating_window, {
        on_create = function(buf)
            vim.keymap.set({ 'n' }, 'q', function()
                if vim.api.nvim_win_is_valid(state.floating.win) then
                    vim.api.nvim_win_hide(state.floating.win)
                end
                state.floating.win = -1
            end, { buffer = buf })
        end,
    })
end

local toggle_bottom_terminal = function()
    state.bottom = toggle_terminal(state.bottom, create_bottom_window, {
        on_create = function(buf)
            vim.keymap.set('n', 'gf', function()
                local f = vim.fn.findfile(vim.fn.expand '<cfile>', '**')

                if f == '' then
                    vim.notify('no file under cursor', vim.log.levels.WARN)
                else
                    if vim.api.nvim_win_is_valid(state.bottom.source_win) then
                        vim.api.nvim_set_current_win(state.bottom.source_win)
                    end
                    vim.schedule(function()
                        vim.cmd('e ' .. f)
                    end)
                end
            end, {
                buffer = buf,
                desc = 'Open file under cursor in previous window',
            })
        end,
    })
end

vim.keymap.set({ 'n', 't', 'v', 'i', 'x' }, '<A-t>', function()
    toggle_float_terminal()
end, { desc = 'Toggle terminal' })

vim.keymap.set({ 'n' }, '<leader>gg', function()
    toggle_lazygit_float_terminal()
end, { desc = 'Toggle terminal' })

vim.keymap.set({ 'n', 'i', 'v', 'x', 't' }, '<C-/>', function()
    toggle_bottom_terminal()
end, { desc = 'Toggle terminal' })
