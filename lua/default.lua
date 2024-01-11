

local option = vim.opt
local buffer = vim.b
-- global settings --

option.showmode = false
option.backspace = { "indent", "eol", "start" }
option.tabstop = 4
option.shiftwidth = 4
option.expandtab = true
option.shiftround = false
option.autoindent = true
option.smartindent = true
option.number = true
option.relativenumber = true
option.wildmenu = true
option.hlsearch = false
option.ignorecase = true
option.smartcase = true
option.completeopt = {"menuone", "noselect"}
option.cursorline = true
option.termguicolors = false
option.signcolumn = "yes"
option.autoread = true
option.title = true
option.swapfile = false
option.backup = false
option.updatetime = 50
option.mouse = "a"
option.exrc = true
option.wrap = false
option.splitright = true
option.clipboard = "unnamedplus"
-- buffer  setting--
buffer.fileenconding = "utf-8"
option.guifont = "monaco:h13"

