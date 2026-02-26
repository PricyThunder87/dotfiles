return {
    "vimpostor/vim-tpipeline",
    init = function()
	vim.g.tpipeline_statusline = ""
	vim.g.tpipeline_clearstl = 1
	vim.o.laststatus = 0
    end,
}
