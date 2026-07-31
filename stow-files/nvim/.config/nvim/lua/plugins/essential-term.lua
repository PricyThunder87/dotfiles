require('essential-term').setup({
    display_mode = 'vertical',
    size = 40,
})

vim.keymap.set("n", "<leader>h", "<cmd>EssentialTermToggle<cr>", { desc = "Toggle Essential Term" })
