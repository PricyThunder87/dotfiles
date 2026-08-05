vim.opt.termguicolors = true
local ccc = require "ccc"

ccc.setup {
  highlighter = {
    auto_enable = true,
    lsp = true,
  },
}

vim.keymap.set("n", "<leader>pic", "<cmd>CccPick<cr>")
