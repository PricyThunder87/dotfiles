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
:▓▓▓░=  %▓▓▓+:@▓▓▓▓▓▓░+  %▓▓&  -▓▓▓  :▓▓▓-  ▓▓▓#   %▓▓▓:&▓▓& -▓▓▓@=   .&▓▓▓-
:█████@:&███*-██▓&##██% *████+ -███::-███-  ▒██▒= -▓██&.▓██% -█████@:=▓████-
:███@██▓@█▒▓*-██@   ██%.+████▒.-█▒▓██████-  :███░:░███- ▒██% -███*▓█▓▒▓#███-
.███+%██████*-██@   ██%+██████%-█████████-  .#███+███+  ▒██% -███:=▓██#=███-
 ███* *█████+-██▓@@@██%*██████%-███++*███-    ▓█████▓=  ▒█#% -██░: =█▒-=███-
.███+  #██▓█=:░██████▓+*█▓  ██*-███  -███-    %█████%   ▒██% -███: .+= =███-
.:::.  .::::. .::::::. .::  ::..:::  .:::.    .:::::.   :::. .:::.     .:::.
		]]
	    },
	    sections = {
		{ section = "header", gap = 1, padding = 1 },
		{ section = "startup", padding = 1, },
		{ section = "keys", gap = 1 }
	    }
	},
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
