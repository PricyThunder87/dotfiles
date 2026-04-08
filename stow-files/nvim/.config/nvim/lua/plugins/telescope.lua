return {
    'nvim-telescope/telescope.nvim', version = '*',
    dependencies = {
        'nvim-lua/plenary.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
	{ "Slotos/telescope-lsp-handlers.nvim", config = function() require("telescope-lsp-handlers").setup() end }
    }
}
