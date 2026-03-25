return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    keys = {
	{ "<leader>e", function() Snacks.explorer.open() end, desc = "Explorer" },
	{ "<leader>h", function() Snacks.terminal.toggle() end, desc = "Terminal" },
    },
    ---@type snacks.Config
    opts = {
	bigfile = { enabled = false },
	dashboard = { enabled = true, },
	explorer = { enabled = true, },
	indent = { enabled = false },
	input = { enabled = true },
	picker = { enabled = true },
	notifier = { enabled = false },
	quickfile = { enabled = true },
	scope = { enabled = true },
	scroll = { enabled = false },
	statuscolumn = { enabled = true },
	terminal = { enabled = true, },
	words = { enabled = true },
    },
}
