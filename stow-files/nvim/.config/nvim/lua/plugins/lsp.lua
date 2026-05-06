return {
    "neovim/nvim-lspconfig",
    dependencies = {
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	{
	    "seblyng/roslyn.nvim",
	    commit = "82d0c9724c3f8eab7342a3a136782b4788070bd0",
	    ---@module 'roslyn.config'
	    ---@type RoslynNvimConfig
	    ft = { "cs", "razor" }
	}
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
		"roslyn",
		"html-lsp"
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

	vim.lsp.config("roslyn", {
	    filetypes = { "cs", "cshtml", "razor" },
	    settings = {
		["csharp|background_analysis"] = {
		    dotnet_analyzer_diagnostics_scope = "none",
		    dotnet_compiler_diagnostics_scope = "openFiles",
		}
	    }
	})
    end
}
