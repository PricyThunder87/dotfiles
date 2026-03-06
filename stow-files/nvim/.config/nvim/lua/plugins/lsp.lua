return {
    "neovim/nvim-lspconfig",
    dependencies = {
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	{
	    "seblyng/roslyn.nvim",
	    ---@module 'roslyn.config'
	    ---@type RoslynNvimConfig
	    ft = { "cs", "razor" },
	    lazy = false,
	    config = {
		on_attach = function(client, bufnr)
		    if vim.bo[bufnr].filetype == "razor" then
			client.server_capabilities.semanticTokensProvider = nil
			client.server_capabilities.signatureHelpProvider = nil
		    end
		end,
		settings = {
		    ["csharp"] = {
			background_analysis = {
			    dotnet_analyzer_diagnostics_scope = "openFiles",
			    dotnet_compiler_diagnostics_scope = "openFiles",
			},
		    },
		    ["razor"] = {
			enabled = true,
		    },
		},
	    },
	},
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

	vim.lsp.config("roslyn", {})

	vim.lsp.enable("lua_ls")
	vim.lsp.config("roslyn", {})
    end,
}
