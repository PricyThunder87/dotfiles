return {
    "seblyng/roslyn.nvim",
    ft = { "cs", "razor" },
    opts = {
	exe = vim.fn.stdpath("data") .. "/mason/bin/roslyn-language-server",
	args = {
	    "--logLevel=Information",
	    "--extensionLogDirectory=", .. vim.fn.stdpath("cache") . "/roslyn-logs",
	},
	config = {
	    on_attach = function(client, bufnr)
		if vim.bo[bufnr].filetype == "razor" then
		    client.server_capabilities.semanticTokensProvider = nil
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
    config = {
	on_attach = function(client, bufnr)
	    if vim.bo[bufnr].filetype == "razor" then
		client.server_capabilities.semanticTokensProvider = nil
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
}
