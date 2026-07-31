vim.cmd.colorscheme 'retrobox'

vim.pack.add({'https://gitlab.com/motaz-shokry/gruvbox.nvim'})
require('gruvbox').setup({
    variant = 'medium',
    enable = {
	lualine = false
    },
})

vim.cmd.colorscheme 'gruvbox'
