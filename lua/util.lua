
--- Utilities module.
local M = {}

--- Gets custom telescope theme.
---@param title string title to use in the telescope prompt.
---@param directory string directory to use as cwd.
---@return {} telescope-theme telescope theme.
local custom_picker_directory = function (title, directory)
  return require('telescope.themes').get_dropdown {
    previewer = true,
    cwd = directory,
    prompt_title = title,
  }
end

--- Gets the value of a system environment variable.
---@param env_variable string environment variable to get the details of.
local get_environement_variable = function (env_variable)
  local env_var = os.getenv(env_variable)
  if env_var ~= nil then
    return env_var
  else
    print("Error: Environment variable '" .. env_variable .. "' is not set.")
  end
end

--- Creates a file picker with specified prompt at a directory saved in a specified environment variable.
--- If the directory has a git folder then the git files picker will be used.
---@param prompt string prompt to use.
---@param env_variable string environment variable to get the directory from.
local get_custom_file_picker = function (prompt, env_variable)
    local dotfiles_dir = get_environement_variable(env_variable)
    if dotfiles_dir ~= nil then
      if M.os.exists(dotfiles_dir) then
        local picker
        if M.os.exists(dotfiles_dir .. "/.git") then
          picker = require("telescope.builtin").git_files
        else
          picker = require("telescope.builtin").find_files
        end

        picker(custom_picker_directory(prompt, dotfiles_dir))
      end

    else
      print("Environment variable '" .. env_variable .. "' variable is not set.")
    end
end

--- Collection of telescope related utilities.
M.telescope = {
  --- Shows a file picker for the $DOTFILES directory.
  get_dotfiles  = function ()
    get_custom_file_picker("🐡 Dotfiles 🐠", "DOTFILES")
  end,

  --- Shows a file picker for the $NVIM_CONFIG directory.
  get_config_files = function ()
    get_custom_file_picker("🗽 Neovim Configuration Files🗼", "NVIM_CONFIG")
  end,

  --- Shows a file picker for the $HOME directory.
  get_home_files = function()
    get_custom_file_picker("🏠 Home Directory 🏡", "HOME")
  end
}

M.os = {
  --- Check if a file or directory exists in this path
  ---@param file string path to look for.
  ---@return true|false if file exists.
  exists = function (file)
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
  is_dir = function (path)
    -- "/" works on both Unix and Windows
    return M.os.exists(path .. "/")
  end

}

return M

