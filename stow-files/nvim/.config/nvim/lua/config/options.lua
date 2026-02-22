vim.opt.ignorecase = true
vim.opt.shiftwidth = 4

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.autoindent = true
vim.opt.smartindent = true

-- Always yank to clipboard
vim.opt.clipboard:append("unnamedplus")

-- Disable auto formatting on write
vim.g.autoformat = false
vim.b.autoformat = false -- buffer-local

-- Make lines wrap and break at convenient points
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.breakindent = true

-- Highlight current line number
vim.opt.cursorline = true

-- Highlight trailing whitespace
vim.opt.list = true
vim.opt.listchars:append("trail:·")

-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
    pattern = "*",
    callback = function()
	vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
    end,
})

-- Disable animations
vim.g.snacks_animate = false
