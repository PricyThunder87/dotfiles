vim.opt.ignorecase = true
vim.opt.shiftwidth = 4

vim.opt.number = true
vim.opt.relativenumber = true

-- Disable auto formatting on write
vim.g.autoformat = false
vim.b.autoformat = false -- buffer-local

-- Highlight current line number
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"

-- Highlight trailing whitespace
vim.opt.list = true
vim.opt.listchars:append("trail:·")

vim.diagnostic.config({
	virtual_text = {
	prefix = "●",
	format = function(diagnostic)
	    return string.format("%s (%s)", diagnostic.message, diagnostic.source)
	end,
	},
})

-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  callback = function()
	vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
  end,
})

-- Disable animations
vim.g.snacks_animate = false
