vim.cmd.colorscheme "retrobox"

vim.pack.add {
  { src = "https://github.com/Aejkatappaja/cendre", name = "cendre" },
  -- { src = "https://gitlab.com/motaz-shokry/gruvbox.nvim", name = "gruvbox" },
}

require("cendre").setup {
  background = "soft",
}

-- require("gruvbox").setup {
--   variant = "medium",
--   enable = {
--     lualine = false,
--   },
-- }

vim.cmd.colorscheme "cendre"
