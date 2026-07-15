vim.g.mapleader = " "

local map = vim.keymap.set

map("i", "jk", "<Esc>", { desc = "Leave insert mode" })
map("n", "<leader>nh", "<Cmd>nohlsearch<CR>", { desc = "Clear search highlights" })

map("n", "<leader>sv", "<C-w>v", { desc = "Split vertically" })
map("n", "<leader>sh", "<C-w>s", { desc = "Split horizontally" })
map("n", "<leader>se", "<C-w>=", { desc = "Equalize splits" })
map("n", "<leader>sx", "<Cmd>close<CR>", { desc = "Close split" })

map("n", "<leader>to", "<Cmd>tabnew<CR>", { desc = "New tab" })
map("n", "<leader>tx", "<Cmd>tabclose<CR>", { desc = "Close tab" })
map("n", "<leader>tn", "<Cmd>tabnext<CR>", { desc = "Next tab" })
map("n", "<leader>tp", "<Cmd>tabprevious<CR>", { desc = "Previous tab" })
