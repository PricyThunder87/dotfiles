return {
    "https://gitlab.com/motaz-shokry/gruvbox.nvim",
    priority = 1000 ,
    config = function()
	require("gruvbox").setup({
	    variant = "medium",
	})
	vim.cmd.colorscheme "gruvbox"
    end,
    opts = ...
}
