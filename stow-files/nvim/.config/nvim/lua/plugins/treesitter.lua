return {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    dependencies = {},
    opts = {
	ensure_installed = { "c_sharp", "html" },
	highlight = { enable = true },
    },
    init = function()
	-- Cargo is used to install the tree sitter CLI
	vim.env.PATH = vim.env.PATH .. ":" .. vim.fn.expand("$HOME/.cargo/bin")

	vim.filetype.add({
	    extension = {
		razor = "razor",
		cshtml = "razor",
	    }
	})
	vim.treesitter.language.register('razor', 'razor')
	vim.api.nvim_create_autocmd("FileType", {
	    pattern = "razor",
	    callback = function()
		vim.treesitter.start()
	    end
	})
    end
}
