require("nvim-treesitter").install { "sql" }
vim.lsp.config("postgres_lsp", {})
vim.lsp.enable "postgres_lsp"

vim.treesitter.start()
