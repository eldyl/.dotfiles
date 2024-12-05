local set = vim.opt

-- Map leader key
vim.g.mapleader = " "

-- File
set.swapfile = false
set.undofile = true

-- Clipboard
set.clipboard = "unnamedplus"

-- Visual
set.guicursor = ""
set.inccommand = "split"
set.signcolumn = "yes"
set.cursorline = true

set.number = true
set.relativenumber = true
set.smartindent = true
set.wrap = false
set.showtabline = 2
set.splitbelow = true
set.splitright = true
set.updatetime = 250 -- faster updates
set.scrolloff = 10 -- show at least this many lines above or below

-- Tabs
set.autoindent = true
set.cindent = true

set.tabstop = 4
set.shiftwidth = 4
set.softtabstop = 4
set.expandtab = true

-- Search
set.ignorecase = true -- when searching
set.smartcase = true -- ... unless capital letter in query

-- Hide .DS_Store files
set.wildignore:append(".DS_Store")

-- words connected with '-' will count as a whole word
set.iskeyword:append("-")
-- Change symbol for diffview
set.fillchars:append({ diff = "╱" })
