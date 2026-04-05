local M = {}

function M.get_visual_selection()
    vim.cmd 'normal! "vy' -- Yank visual selection to register v
    return vim.fn.getreg 'v'
end

function M.translate_selection(target_lang)
    local text = M.get_visual_selection()
    if not text or text == '' then
        vim.notify('No text selected', vim.log.levels.WARN)
        return
    end

    -- Google Translate API URL (replace with an actual API key if required)
    local url = 'https://translate.googleapis.com/translate_a/single?client=gtx&sl=auto&tl='
        .. target_lang
        .. '&dt=t&q='
        .. vim.uri_encode(text, 'rfc3986')

    vim.net.request(
        url,
        {},

        -- UI apis require being handled on main thread, otherwise you get
        --   E5560: 'vim.notify' must not be called in a fast event context.
        vim.schedule_wrap(function(err, response)
            if err then
                vim.notify('Translation failed: ' .. err, vim.log.levels.ERROR)
                return
            end

            local ok, decoded = pcall(vim.fn.json_decode, response.body)
            if not ok or type(decoded) ~= 'table' then
                vim.notify('Invalid JSON from translation', vim.log.levels.ERROR)
                return
            end

            local translated_text = ''
            for _, item in ipairs(decoded[1] or {}) do
                if type(item) == 'table' and type(item[1]) == 'string' then
                    translated_text = translated_text .. item[1]
                end
            end

            if translated_text ~= '' then
                translated_text = translated_text:gsub('\\u([0-9a-fA-F]+)', function(hex)
                    return require('utf8').char(tonumber(hex, 16))
                end)

                -- Replace the visual selection with translated text
                vim.api.nvim_feedkeys('gv', 'x', false) -- Reselect previous visual selection
                vim.api.nvim_feedkeys('c' .. translated_text .. '\027', 'x', false) -- Replace with translated text
            else
                vim.notify('Could not parse translation response', vim.log.levels.ERROR)
            end
        end)
    )
end

return M
