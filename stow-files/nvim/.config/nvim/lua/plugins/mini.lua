return {
    'nvim-mini/mini.nvim',
    version = false,
    config = function()
	require("mini.ai").setup()
	require("mini.align").setup()
	require("mini.files").setup({
	    windows = {
		max_number = 3,
		preview = true,
		width_preview = 75
	    }
	})
	vim.keymap.set("n", "<leader>e", "<cmd>lua MiniFiles.open()<cr>")
	require("mini.pairs").setup()
	require("mini.splitjoin").setup()
	require("mini.surround").setup()
	require("mini.clue").setup()
	require("mini.cmdline").setup()
	require("mini.icons").setup()
	require("mini.indentscope").setup({
	    draw = {
		delay = 0,
		animation = function()
		    return 0
		end
	    }
	})
	require("mini.notify").setup()
    end
}
