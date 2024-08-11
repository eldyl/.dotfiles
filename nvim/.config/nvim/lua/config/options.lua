local opt = vim.opt

-- Map leader key
vim.g.mapleader = " "

-- File
opt.swapfile = false
opt.undofile = true

-- Clipboard
opt.clipboard = "unnamedplus"

-- Visual
opt.guicursor = ""
opt.inccommand = "split"
opt.signcolumn = "yes"
opt.cursorline = true

opt.number = true
opt.relativenumber = true
opt.smartindent = true
opt.wrap = false
opt.showtabline = 2
opt.splitbelow = true
opt.splitright = true
opt.updatetime = 250 -- faster updates
opt.scrolloff = 10 -- show at least this many lines above or below

-- Tabs
opt.autoindent = true
opt.cindent = true

opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true

-- Search
opt.ignorecase = true -- when searching
opt.smartcase = true -- ... unless capital letter in query

-- Hide .DS_Store files
opt.wildignore:append(".DS_Store")

-- words connected with '-' will count as a whole word
opt.iskeyword:append("-")
-- Change symbol for diffview
opt.fillchars:append({ diff = "╱" })
