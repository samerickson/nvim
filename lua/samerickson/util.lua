local M = {}

M.os = {
  --- Check if a file or directory exists in this path
  ---@param file string path to look for.
  ---@return true|false if file exists.
  exists = function(file)
    local ok, _, code = os.rename(file, file)
    if not ok then
      if code == 13 then
        -- Permission denied, but it exists
        return true
      end
      return false
    end
    return true
  end,

  --- Check if a directory exists in this path
  is_dir = function(path)
    -- "/" works on both Unix and Windows
    return M.os.exists(path .. "/")
  end,
}

M.toggleTest = function()
  -- TODO: Ideally this would be more intelligent than just looking
  -- for a test file in the same directory. But this is all I need
  -- for now.
  local typescriptFileName = vim.fn.expand("%"):match("(.*)%.ts$")
  local targetFile = ""

  -- Check if we are in a test file already
  local testFileName = typescriptFileName:match("([^/\\])%.test$")
  if testFileName then
    targetFile = string.gsub(typescriptFileName, "%.test", ".ts")
  else
    targetFile = typescriptFileName .. ".test.ts"
  end

  vim.api.nvim_command("edit " .. targetFile)
end

function M.get_git_branch()
  return vim.fn.system("git rev-parse --abbrev-ref HEAD"):gsub("%\n", "")
end

M.open_jira = function()
  local jira_url = os.getenv("JIRA_URL")

  if jira_url then
    local git_branch = M.get_git_branch()
    if git_branch then
      local jira_ticket = git_branch:match("(%w+-%d+)")

      print(jira_url .. jira_ticket)

      if jira_ticket then
        vim.fn.system("wslview " .. jira_url .. jira_ticket)
      else
        vim.notify("Could not parse jira ticket", vim.log.levels.ERROR)
      end
    else
      vim.notify("Not in a git repo.", vim.log.levels.ERROR)
    end
  else
    vim.notify("Environment variable JIRA_URL not set", vim.log.levels.ERROR)
  end
end

return M
