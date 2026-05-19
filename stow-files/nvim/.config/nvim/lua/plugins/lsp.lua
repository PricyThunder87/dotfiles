return {
    "neovim/nvim-lspconfig",
    dependencies = {
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"seblyng/roslyn.nvim",
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
	    }
	})

	vim.lsp.config("lua_ls", {
	    settings = {
		Lua = {
		    diagnostics = {
			globals = {
			    "vim", "opts"
			}
		    }
		}
	    }
	})

	vim.lsp.enable("roslyn_ls")
	vim.lsp.config("roslyn_ls", {
	    filetypes = { "cs", "cshtml", "razor" },
	    settings = {
		["csharp|background_analysis"] = {
		    dotnet_analyzer_diagnostics_scope = "fullSolution",
		    dotnet_compiler_diagnostics_scope = "openFiles",
		}
	    }
	})
    end
}
