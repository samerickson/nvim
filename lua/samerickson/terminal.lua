local state = {
    floating = {
        buf = -1,
        win = -1,
    },
    bottom = {
        buf = -1,
        win = -1,
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

    local buf = create_or_reuse_buffer(opts)
    local win = vim.api.nvim_open_win(buf, true, win_config)

    return { win = win, buf = buf }
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

    local buf = create_or_reuse_buffer(opts)

    local win = vim.api.nvim_open_win(buf, true, win_config)

    return { buf = buf, win = win }
end

local toggle_terminal = function(terminal_state, create_function)
    if not vim.api.nvim_win_is_valid(terminal_state.win) then
        terminal_state = create_function { buf = terminal_state.buf }

        if vim.bo[terminal_state.buf].buftype ~= 'terminal' then
            vim.cmd.terminal()
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

local toggle_float_terminal = function()
    state.floating = toggle_terminal(state.floating, create_floating_window)
end

local toggle_bottom_terminal = function()
    state.bottom = toggle_terminal(state.bottom, create_bottom_window)
end

vim.keymap.set({ 'n', 't' }, '<A-t>', function()
    toggle_float_terminal()
end, { desc = 'Toggle terminal' })

vim.keymap.set({ 'n', 'i', 'v', 'x', 't' }, '<C-/>', function()
    toggle_bottom_terminal()
end, { desc = 'Toggle terminal' })
