vim.api.nvim_create_autocmd("InsertEnter", {
    callback = function()
	vim.opt.relativenumber = false
    end,
})

-- Delete all trailing whitespaces in a file if it's not binary nor a diff
function _G.trim_trailing_whitespaces()
    if not vim.o.binary and vim.o.filetype ~= 'diff' then
        local current_view = vim.fn.winsaveview()
        vim.cmd([[keeppatterns %s/\s\+$//e]])
        vim.fn.winrestview(current_view)
    end
end

-- Show relative line numbers in normal mode
vim.api.nvim_create_autocmd("InsertLeave", {
  callback = function()
    vim.opt.relativenumber = true
    trim_trailing_whitespaces()
  end,
})

-- Disable auto-extension of a comment on a newline
vim.api.nvim_create_autocmd('BufWinEnter', {
    command = 'set formatoptions-=cro',
})
