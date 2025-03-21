local function toggle_test_file()
  local bufname = vim.api.nvim_buf_get_name(0) -- Get full path of current buffer
  if bufname == "" then
    require("snacks.notify").error("No active buffer")
    return
  end

  local dirname = vim.fn.fnamemodify(bufname, ":h") -- Get directory
  local basename = vim.fn.fnamemodify(bufname, ":t:r") -- Get filename without extension
  local ext = vim.fn.fnamemodify(bufname, ":e") -- Get the file extension

  -- TODO: this solution assumes that the main file and test file are in the same directory
  -- this should be expanded upon to account for test files that could be located elsewhere
  -- like in a /tests directory.
  local testfile = string.format("%s/%s.test.%s", dirname, basename, ext) -- Construct test file path
  local mainfile_no_extension = string.format("%s/%s.", dirname, basename:gsub("%.test", "")) -- Construct main file path

  if basename:match("%.test$") then
    -- If we're in a test file, switch back to the main file
    local mainfile = mainfile_no_extension .. ext
    if vim.fn.filereadable(mainfile) == 1 then
      vim.cmd("edit " .. mainfile)

      -- If the file extension did not match we might be dealing with a Vue file
      -- TODO: Support .spec.ts files for vue tests?
    elseif vim.fn.filereadable(mainfile_no_extension .. "vue") == 1 then
      vim.cmd("edit " .. mainfile_no_extension .. "vue")
    else
      require("snacks.notify").error("Main file not found: " .. mainfile_no_extension .. "*", { title = "404" })
    end
  else
    -- If we're in a main file, switch to the test file
    if vim.fn.filereadable(testfile) == 1 then
      vim.cmd("edit " .. testfile)
    else
      -- TODO: if we are in a test directory then we might not have the .test.x format
      local testfile_dir = vim.fn.filereadable(string.format("%s/__tests__/%s.test.%s", dirname, basename, ext))

      if testfile_dir then
        vim.cmd("edit " .. testfile)
      else
        require("snacks.notify").error("Test file not found: " .. testfile, { title = "404" })
      end
    end
  end
end

-- Map to a keybinding (e.g., <leader>t)
vim.keymap.set({ "n" }, "<leader>ct", function()
  toggle_test_file()
end, { desc = "Toggle main and test file" })
