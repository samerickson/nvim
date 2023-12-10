
--- Utilities module.
local M = {}

--- Gets custom telescope theme.
---@param title string title to use in the telescope prompt.
---@param directory string directory to use as cwd.
---@return {} telescope-theme telescope theme.
local custom_picker_directory = function (title, directory)
  return require('telescope.themes').get_dropdown {
    previewer = false,
    cwd = directory,
    prompt_title = title,
  }
end

--- Gets the value of a system environment variable.
---@param env_variable string environment variable to get the details of.
function M.get_environement_variable(env_variable)
  local env_var = os.getenv(env_variable)

  if env_var ~= nil then
    return env_var
  else
    print("Error: Environment variable '" .. env_variable .. "' is not set.")
  end
end

--- Collection of telescope related utilities.
M.telescope = {

  --- Shows a file picker of the files in the $DOTFILES directory.
  get_dotfiles  = function ()
    local dotfiles_dir = require("util").get_environement_variable("DOTFILES")
    if dotfiles_dir ~= nil then
      require("telescope.builtin").git_files(custom_picker_directory("🐡 Dotfiles 🐠", dotfiles_dir))
    else
      print("Environment variable 'DOTFILES' variable is not set.")
    end
  end,

  --- Shows a file picker of the file in the $NVIM_CONFIG directory.
  get_configfiles = function ()
    local neovim_config_dir = require("util").get_environement_variable("NVIM_CONFIG")
    if neovim_config_dir ~= nil then
      require("telescope.builtin").find_files( custom_picker_directory("🗽 Neovim Configuration Files🗼", neovim_config_dir))
    else
      print("Environment variable 'NVIM_CONFIG' is not set.");
    end
  end
}

return M

