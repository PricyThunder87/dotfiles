return {
    "nvim-lualine/lualine.nvim",
    enabled = false,
    event = "VeryLazy",
    config = function(_, opts)
	require("lualine").setup(opts)
	vim.o.laststatus = 0
	vim.o.showmode = false
	vim.api.nvim_create_autocmd({ "WinEnter", "BufWinEnter", "VimResized" }, {
	    callback = function()
		vim.schedule(function()
		    vim.o.laststatus = 0
		end)
	    end,
	})
    end,
    opts = {
        options = {
            globalstatus = true,
        },
        sections = {
            lualine_x = {
                {
                    function()
                        return require("noice").api.status.command.get()
                    end,
                    cond = function()
                        return package.loaded["noice"] and require("noice").api.status.command.has()
                    end,
                },
            },
        },
    },
}
