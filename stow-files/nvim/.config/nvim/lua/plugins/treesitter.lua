return {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',
    config = function(_, opts)
	local ts = require('nvim-treesitter')

	ts.install({
	    'bash', 'c', 'cpp', 'c_sharp', 'css', 'html', 'javascript', 'json',
	    'jsx', 'lua', 'python', 'rust', 'tsx', 'typescript', 'vim',
	})

	vim.treesitter.language.register("html", "razor")
	vim.api.nvim_create_autocmd('FileType', {
	    callback = function()
		pcall(vim.treesitter.start)
	    end,
	})
    end,
}
