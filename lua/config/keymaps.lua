local map = vim.keymap.set

map({ "i" }, "jk", "<Esc>", { silent = true })

-- Make the windows clipboard manager work in neovim
map({ "i" }, "<C-v>", "<C-r>*", { silent = true })

map({ "i" }, "<C-e>", "<Esc>$a", { silent = true })
map({ "i" }, "<C-b>", "<Esc>^i", { silent = true })
