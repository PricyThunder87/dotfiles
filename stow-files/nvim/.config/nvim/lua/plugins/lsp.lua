return {
    "neovim/nvim-lspconfig",
    dependencies = {
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim"
    },
    config = function()
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)

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
