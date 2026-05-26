return {
    "neovim/nvim-lspconfig",
    dependencies = {
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim"
    },
    config = function()
	-- Add Roslyn registry to mason
	require("mason").setup({
	    registries = {
		"github:mason-org/mason-registry",
		"github:Crashdummyy/mason-registry",
	    }
	})

	require("mason-lspconfig").setup({
	    ensure_installed = {
		"lua_ls",
		"html-lsp"
	    }
	})

	vim.lsp.config("lua_ls", {
	    settings = {
		Lua = {
		    diagnostics = {
			globals = {
			    "vim"
			}
		    }
		}
	    }
	})
    end
}
