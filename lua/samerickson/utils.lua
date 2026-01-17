---@class SamEricksonUtils
---@field open_link fun(): string|nil error message when system command fails
---Utility helpers for Sam Erickson's Neovim config.
---Keep UI-focused helper functions consolidated here.
local M = {} ---@type SamEricksonUtils

---Open the provided URL using `vim.ui.open` and report failures.
---@param url string fully-qualified http(s) URL
---@return string|nil err
local function do_open(url)
    local cmd, err = vim.ui.open(url)
    ---@type vim.SystemCompleted|nil
    local rv = cmd and cmd:wait(1000) or nil
    if cmd and rv and rv.code ~= 0 then
        err = ('vim.ui.open: command %s (%d): %s'):format(
            (rv.code == 124 and 'timeout' or 'failed'),
            rv.code,
            vim.inspect(cmd.cmd)
        )
    end
    return err
end

---Resolve a URL under the cursor and open it.
---Supports raw protocols (http/https) and GitHub-style `owner/repo` shorthand.
---@return string|nil err error string when the system browser command fails
function M.open_link()
    local url = vim.ui._get_urls()[1]
    if url:match '%w://' then
        return do_open(url)
    end

    -- consider anything that looks like string/string a github link
    local plugin_url_regex = '[%a%d%-%.%_]*%/[%a%d%-%.%_]*'
    local link = string.match(url, plugin_url_regex)
    if link then
        return do_open(string.format('https://www.github.com/%s', link))
    end

    vim.notify 'No link found under cursor'
end

return M
