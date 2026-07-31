require('vim._core.ui2').enable()

vim.opt.shiftwidth = 4
vim.opt.number = true
vim.opt.relativenumber = true

vim.cmd('filetype indent on')
vim.opt.autoindent = false
vim.opt.smartindent = false

-- Case insensitive
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Yank to clipboard
vim.opt.clipboard:append('unnamedplus')

-- Wrap on word
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.breakindent = true

vim.opt.cursorline = true

-- Highlight trailing whitespace
vim.opt.list = true
vim.opt.listchars:append('trail:·')

-- Maintain undo history between sessions
vim.o.undofile = true

-- AUTOCOMMANDS

-- Disable auto-comment extension on newline
vim.cmd('autocmd BufEnter * set formatoptions-=cro')
vim.cmd('autocmd BufEnter * setlocal formatoptions-=cro')

-- Highlight yanked text
vim.api.nvim_create_autocmd('TextYankPost', {
    pattern = '*',
    callback = function()
	vim.hl.on_yank({ higroup = 'IncSearch', timeout = 200 })
    end,
})

-- Switch to absolute line numbers in insert mode
vim.api.nvim_create_autocmd('InsertEnter', {
    callback = function()
	vim.opt.relativenumber = false
    end,
})

vim.api.nvim_create_autocmd('InsertLeave', {
    callback = function()
	vim.opt.relativenumber = true
	trim_trailing_whitespaces()
    end,
})

-- Set shift width to 2 in HTML-adjacent filetypes
local leet_indent = vim.api.nvim_create_augroup('LeetIndent', { clear = true })

vim.api.nvim_create_autocmd('FileType', {
  group = leet_indent,
  pattern = { 'typescriptreact', 'javascriptreact', 'html', 'css', 'json' },
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.expandtab = true -- Converts tabs to spaces
  end,
})

-- Delete all trailing whitespaces in a file if it's not binary nor a diff
-- This is called in the InsertLeave block above
function _G.trim_trailing_whitespaces()
    if not vim.o.binary and vim.o.filetype ~= 'diff' then
        local current_view = vim.fn.winsaveview()
        vim.cmd([[keeppatterns %s/\s\+$//e]])
        vim.fn.winrestview(current_view)
    end
end
