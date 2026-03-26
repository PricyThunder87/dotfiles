return {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
	require("bufferline").setup()
	vim.keymap.set("n", "<leader>bd", "<cmd>bd<cr>")
	vim.keymap.set("n", "<leader>bo", "<cmd>BufferLineCloseOthers<cr>")
    end
}
