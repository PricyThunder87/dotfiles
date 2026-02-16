return {
    "mason-org/mason-lspconfig.nvim",
    opts = {},
    dependencies = {
	{
	    "mason-org/mason.nvim",
	    opts = {}
	},
	"neovim/nvim-lspconfig",
    },
    config = function()
	require("mason").setup({
	    registries = {
		"github:mason-org/mason-registry",
		"github:Crashdummyy/mason-registry",
	    }
	})

	vim.lsp.config("lua_ls", {
	    settings = {
		Lua = {
		    diagnostics = {
			globals = { "vim", "opts" },
		    },
		    runtime = {
			version = "LuaJIT",
		    },
		    workspace = {
			checkThirdParty = false,
			library = vim.api.nvim_get_runtime_file("", true),
		    },
		    telemetry = {
			enable = false,
		    },
		},
	    },
	})

	vim.lsp.enable("lua_ls")
    end,
}
