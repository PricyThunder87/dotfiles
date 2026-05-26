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
	dashboard = {
	    enabled = true,
	    preset = {
		header = [[
████    ███   ████████     █████    ███   ███   ███     ███  ███  ███       ███
█████   ███  ██      ██   ███████   ███   ███   ████   ███   ███  █████   █████
███ ███ ███  ██      ██  ██     ██  █████████    ████ ████   ███  ███ █████ ███
███  ██████  ██      ██  ██     ██  █████████     ███ ███    ███  ███  ███  ███
███   █████  ██      ██  █████████  ███   ███     ███████    ███  ███   █   ███
███    ████   ████████   ██     ██  ███   ███      █████     ███  ███       ███
		]]
	    },
	    sections       = {
		{ section = "header", gap = 1, padding = 1 },
		{ section = "startup", padding = 1, },
		{ section = "keys", gap = 1 }
	    }
	},
	explorer = { enabled = true, },
	indent = { enabled = false },
	input = { enabled = true },
	picker =
	{
	    enabled = true,
	    sources = {
		explorer = {
		    win = {
			list = {
			    wo = {
				number = true,
				relativenumber = true
			    },
			    keys = {
				["A"] = "explorer_add_dotnet",
			    }
			}
		    },
		    actions = {
			explorer_add_dotnet = function(picker)
			    local dir = picker:dir()
			    local easydotnet = require("easy-dotnet")

			    easydotnet.create_new_item(dir, function(item_path)
				local tree = require("snacks.explorer.tree")
				local actions = require("snacks.explorer.actions")
				tree:open(dir)
				tree:refresh(dir)
				actions.update(picker, { target = item_path })
				picker:focus()
			    end)
			end,
		    }
		}
	    }
	},
	notifier = { enabled = false },
	quickfile = { enabled = true },
	scope = { enabled = true },
	scroll = { enabled = false },
	statuscolumn = { enabled = true },
	terminal = { enabled = true, },
	words = { enabled = true },
    },
}
