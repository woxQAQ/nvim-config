local global = vim.g

global.mapleader = " "
vim.keymap.set("n", "<a-Tab>", "<cmd>bNext<CR>", {desc = 'next buffer', silent = true })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("t", "<ESC>", "<C-\\><C-n>", { silent = true, noremap = true })
vim.keymap.set("n", "<a-=>", "<cmd>3split term://zsh<CR>", { silent = true, noremap = true })
vim.keymap.set("t", "<A-=>", "<C-\\><C-n>:bdelete! %<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>bc", "<cmd>bd<CR>", { desc = 'close buffer'})
vim.keymap.set("n", "<leader>sv", "<cmd>vsplit<CR>", { desc = 'veritical split'})
vim.keymap.set('i', "<c-u>", "<esc>viwUea", {desc = 'upcase cursor word'})
vim.keymap.set("i", "<c-t>", "<esc>b~lea", {desc = "将光标处的单词首字母改为大写"})
vim.keymap.set("n", "<leader>q", "<cmd>x<cr>", {desc = "save and quit"})
vim.keymap.set('n', "<leader>Q", "<cmd>qa!<cr>", {desc = "quit without save if modified"})

vim.keymap.set("v", "<", "<gv", {silent = true, desc = "缩进"})
vim.keymap.set("v", ">", ">gv", {silent = true, desc = "缩进"})
vim.keymap.set("n", "<leader>sh", "<C-w>h", {silent = true, desc = "切换窗口"})
vim.keymap.set("n", "<leader>sj", "<C-w>j", {silent = true, desc = "切换窗口"})
vim.keymap.set("n", "<leader>sk", "<C-w>k", {silent = true, desc = "切换窗口"})
vim.keymap.set("n", "<leader>sl", "<C-w>l", {silent = true, desc = "切换窗口"})
