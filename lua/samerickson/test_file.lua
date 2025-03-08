local function toggle_test_file()
  local bufname = vim.api.nvim_buf_get_name(0) -- Get full path of current buffer
  if bufname == "" then
    print("No active buffer")
    return
  end

  local dirname = vim.fn.fnamemodify(bufname, ":h") -- Get directory
  local basename = vim.fn.fnamemodify(bufname, ":t:r") -- Get filename without extension
  local ext = vim.fn.fnamemodify(bufname, ":e") -- Get the file extension

  -- TODO: this solution assumes that the main file and test file are in the same directory
  -- this should be expanded upon to account for test files that could be located elsewhere
  -- like in a /tests directory.
  local testfile = dirname .. "/" .. basename .. ".test." .. ext -- Construct test file path
  local mainfile = dirname .. "/" .. basename:gsub("%.test$", "") .. "." .. ext -- Construct main file path

  if basename:match("%.test$") then
    -- If we're in a test file, switch back to the main file
    if vim.fn.filereadable(mainfile) == 1 then
      vim.cmd("edit " .. mainfile)
    else
      print("Main file not found: " .. mainfile)
    end
  else
    -- If we're in a main file, switch to the test file
    if vim.fn.filereadable(testfile) == 1 then
      vim.cmd("edit " .. testfile)
    else
      print("Test file not found: " .. testfile)
    end
  end
end

-- Map to a keybinding (e.g., <leader>t)
vim.keymap.set({ "n" }, "<leader>ct", function()
  toggle_test_file()
end, { desc = "Toggle main and test file" })
