return {
    "GustavEikaas/easy-dotnet.nvim",
    dependencies = { "nvim-lua/plenary.nvim", 'mfussenegger/nvim-dap', 'nvim-telescope/telescope.nvim', },
    config = function()
	local dotnet = require("easy-dotnet")
	dotnet.setup({
	    lsp = {
		enabled = true, -- Enable builtin roslyn lsp
		set_fold_expr = false,
		preload_roslyn = true, -- Start loading roslyn before any buffer is opened
		roslynator_enabled = true, -- Automatically enable roslynator analyzer
		easy_dotnet_analyzer_enabled = true, -- Enable roslyn analyzer from easy-dotnet-server
		auto_refresh_codelens = true,
		suggest_updates = true, -- Periodically suggest roslyn-language-server updates
		analyzer_assemblies = {}, -- Any additional roslyn analyzers you might use like SonarAnalyzer.CSharp
		config = {},
	    },
	    auto_bootstrap_namespace = {
		--block_scoped, file_scoped
		type = "file_scoped",
		enabled = true,
		use_clipboard_json = {
		    behavior = "prompt", --'auto' | 'prompt' | 'never',
		    register = "+", -- which register to check
		},
	    },
	    server = {
		---@type nil | "Off" | "Critical" | "Error" | "Warning" | "Information" | "Verbose" | "All"
		log_level = nil,
	    },
	    picker = "telescope",
	})

	vim.keymap.set("n", "<leader>rp", function()
	    dotnet.run_project()
	end)
    end
}
