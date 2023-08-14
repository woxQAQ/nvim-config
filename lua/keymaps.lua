local global = vim.g
global.mapleader = " "

vim.keymap.set("n", "<A-Tab>", "<cmd>bNext<CR>", { silent = true })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("t", "<ESC>", "<C-\\><C-n>", { silent = true, noremap = true })
vim.keymap.set("n", "<A-=>", "<cmd>3split term://bash<CR>", { silent = true, noremap = true })
vim.keymap.set("t", "<A-=>", "<C-\\><C-n>:bdelete! %<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>bc", "<cmd>bd<CR>")
vim.keymap.set("n", "<leader>sv", "<cmd>vsplit<CR>")
