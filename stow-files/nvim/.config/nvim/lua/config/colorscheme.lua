vim.cmd.colorscheme "retrobox"

vim.pack.add { { src = "https://gitlab.com/motaz-shokry/gruvbox.nvim", name = "gruvbox" } }
require("gruvbox").setup {
  variant = "medium",
  enable = {
    lualine = false,
  },
}

vim.cmd.colorscheme "gruvbox"
