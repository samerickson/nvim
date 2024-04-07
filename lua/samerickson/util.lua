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

return M
