require("diffbandit").setup()

vim.keymap.set("n", "<leader>git", "<cmd>DiffBanditGitMenu<cr>", { desc = "DiffBandit git menu" })
vim.keymap.set("n", "<leader>dif", "<cmd>DiffBanditGitCurrent<cr>", { desc = "DiffBandit diff current file" })
