require("diffbandit").setup()

vim.keymap.set("n", "<leader>git", "<cmd>DiffBanditGitMenu<cr>")
vim.keymap.set("n", "<leader>dif", "<cmd>DiffBanditGitCurrent<cr>")
