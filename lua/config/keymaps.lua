local map = vim.keymap.set

map({ "i" }, "jk", "<Esc>", { silent = true })

-- Make the windows clipboard manager work in neovim
map({ "i" }, "<C-v>", "<C-r>+", { silent = true })

map({ "i" }, "<C-e>", "<Esc>$a", { silent = true })
map({ "i" }, "<C-b>", "<Esc>^i", { silent = true })

map({ "n" }, "gt", function()
  require("samerickson.util").toggleTest()
end, { silent = true, desc = "Toggle between test/implementation" })
-- Map a key to trigger translation

map({ "v" }, "<leader>t", function()
  require("samerickson.translate").translate_selection("fr")
end, { noremap = true, silent = true, desc = "Translate" })

map("n", "<leader>fC", function()
  Snacks.picker.files({ cwd = "~/.local/share/nvim" })
end, { desc = "Search plugin files" })

map("n", "<leader>fG", function()
  Snacks.picker.grep({ cwd = "~/.local/share/nvim" })
end, { desc = "Grep plugin files" })

map({ "v" }, "<leader>x", '"_d', { desc = "Delete without polluting registers" })
map("n", "<leader>gj", function()
  require("samerickson.util").open_jira()
end, { desc = "Open JIRA ticket" })

map("i", "<tab>", function()
  local _, col = unpack(vim.api.nvim_win_get_cursor(0))
  if col == 0 then
    local line = vim.api.nvim_get_current_line()
    if line:match("^%s*$") then
      -- If the line is empty, then we need to use a custom handler to account for
      -- the white space being removed when exiting insert mode
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>"_ddko', true, true, true), "n", false)
    else
      -- If line is not empty, just jump to the correct indent for the line
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>==I", true, true, true), "n", false)
    end
  else
    -- Default case, just insert the typical tab character
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<tab>", true, true, true), "i", false)
  end
end, {
  desc = "Smart <tab> to indent on empty line",
  noremap = true, -- Prevents recursive loop
})

map("i", "<CR>", function()
  local _, col = unpack(vim.api.nvim_win_get_cursor(0))
  local line = vim.api.nvim_get_current_line()

  local left = line:sub(1, col):match("[^%s]%s*$")
  local right = line:sub(col + 1):match("^%s*([^%s])")

  local pairs = {
    ["{"] = "}",
    ["["] = "]",
    ["<"] = ">",
    ["("] = ")",
  }

  local pair = pairs[left]

  if pair ~= nil and right == pair then
    -- Exit insert mode and open a new line below
    vim.api.nvim_feedkeys("\n" .. vim.api.nvim_replace_termcodes("<Esc>O", true, true, true), "n", false)
  else
    -- Insert a newline directly (use actual newline char instead of <CR>)
    vim.api.nvim_feedkeys("\n", "i", false)
  end
end, {
  desc = "Smart <CR> between braces in insert mode",
  noremap = true, -- very important to prevent recursive map loop
})
