require("vim._core.ui2").enable()

vim.opt.shiftwidth = 4

vim.opt.number = true
vim.opt.relativenumber = true

vim.cmd("filetype indent on")
vim.opt.autoindent = false
vim.opt.smartindent = false

-- Always yank to clipboard
vim.opt.clipboard:append("unnamedplus")

vim.g.autoformat = false
vim.b.autoformat = false

-- Wrap on word
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.breakindent = true

-- Highlight current line number
vim.opt.cursorline = true

-- Highlight trailing whitespace
vim.opt.list = true
vim.opt.listchars:append("trail:·")

-- Maintain undo history between sessions
vim.o.undofile = true
