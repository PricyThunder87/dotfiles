-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
    pattern = "*",
    callback = function()
	vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
    end,
})

-- Use absolute line numbers when in insert mode
vim.api.nvim_create_autocmd("InsertEnter", {
    callback = function()
	vim.opt.relativenumber = false
    end,
})

vim.api.nvim_create_autocmd("InsertLeave", {
    callback = function()
	vim.opt.relativenumber = true
	trim_trailing_whitespaces()
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

-- Disable automatic comment extension on new line
vim.api.nvim_create_autocmd('BufWinEnter', {
    command = 'set formatoptions-=cro',
})
