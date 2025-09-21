return {
    'gbprod/yanky.nvim',
    opts = {
        ring = { history_length = 20 },
        highlight = { timer = 150 },
    },
    keys = {
        {
            '<leader>p',
            function()
                local history = require('yanky.history').all()
                local entries = {}

                -- build display list with [id] prefix
                for i, entry in ipairs(history) do
                    local first = tostring(entry.regcontents):gsub('\n', ' '):gsub('%s+', ' '):sub(1, 80)
                    table.insert(entries, string.format('[%d] %s', i, first))
                end

                local function detect_lang(snippet)
                    local first_line
                    if type(snippet) == 'table' then
                        first_line = snippet[1] or ''
                    else
                        first_line = tostring(snippet):match '([^\n]+)' or ''
                    end
                    first_line = first_line:lower()
                    if first_line:match '^%s*function' or first_line:match 'local%s' then
                        return 'lua'
                    elseif first_line:match '^%s*import' or first_line:match 'def%s' then
                        return 'python'
                    elseif first_line:match '^%s*const' or first_line:match '^%s*let' or first_line:match '^%s*var' then
                        return 'javascript'
                    elseif first_line:match '^%s*class' then
                        return 'java'
                    else
                        return 'text'
                    end
                end

                require('fzf-lua').fzf_exec(entries, {
                    prompt = 'Yank history> ',
                    previewer = 'builtin',
                    preview = {
                        fn = function(s)
                            local item = s[1] or ''
                            local idx = tonumber(item:match '^%[(%d+)%]')
                            if not idx then
                                return ''
                            end
                            local e = history[idx]
                            if not e then
                                return ''
                            end
                            local c = e.regcontents
                            if type(c) == 'table' then
                                return table.concat(c, '\n')
                            end
                            return tostring(c)
                        end,
                        syntax = function(s)
                            local item = s[1] or ''
                            local idx = tonumber(item:match '^%[(%d+)%]')
                            if not idx then
                                return 'text'
                            end
                            local e = history[idx]
                            if not e then
                                return 'text'
                            end
                            return detect_lang(e.regcontents)
                        end,
                        lines = 50,
                    },
                    actions = {
                        ['default'] = function(selected)
                            if not selected or not selected[1] then
                                return
                            end
                            local idx = tonumber(selected[1]:match '^%[(%d+)%]')
                            if not idx then
                                return
                            end
                            local e = history[idx]
                            if not e then
                                return
                            end
                            require('yanky.picker').actions.put('p', e.regcontents)
                        end,
                    },
                    -- Highlight number typed in prompt as top match
                    fzf_opts = {
                        ['--tiebreak'] = 'index',
                        ['--nth'] = '1,2', -- search [id] first, then content
                        ['--exact'] = '', -- prioritize exact matches for number
                    },
                    fzf_glob = true,
                })
            end,
            desc = 'Yank history (fzf-lua, treesitter, number-prioritized)',
        },

        { 'p', '<Plug>(YankyPutAfter)', mode = { 'n', 'x' }, desc = 'Put yanked text after cursor' },
        { 'P', '<Plug>(YankyPutBefore)', mode = { 'n', 'x' }, desc = 'Put yanked text before cursor' },
        { '=p', '<Plug>(YankyPutAfterLinewise)', desc = 'Put yanked text in line below' },
        { '=P', '<Plug>(YankyPutBeforeLinewise)', desc = 'Put yanked text in line above' },
        { '[y', '<Plug>(YankyCycleForward)', desc = 'Cycle forward through yank history' },
        { ']y', '<Plug>(YankyCycleBackward)', desc = 'Cycle backward through yank history' },
        { 'y', '<Plug>(YankyYank)', mode = { 'n', 'x' }, desc = 'Yanky yank' },
    },
}
