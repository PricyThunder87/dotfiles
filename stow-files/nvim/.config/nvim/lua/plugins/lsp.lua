return {
    "neovim/nvim-lspconfig",
    dependencies = {
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
    },
    config = function()
	require("mason").setup({
	    registries = {
		"github:mason-org/mason-registry",
		"github:Crashdummyy/mason-registry",
	    }
	})
	require("mason-lspconfig").setup({
	    ensure_installed = {
		"lua_ls",
	    },
	})

	vim.lsp.config("lua_ls", {
	    settings = {
		Lua = {
		    diagnostics = {
			globals = { "vim", "opts" },
		    },
		},
	    },
	})

	vim.lsp.enable("lua_ls")
	vim.lsp.enable("roslyn")
    end,
}
