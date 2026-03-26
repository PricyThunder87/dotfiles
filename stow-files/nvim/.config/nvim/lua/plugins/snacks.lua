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
                .88888888:.
               88888888.88888.
             .8888888888888888.
             888888888888888888
             88' _`88'_  `88888
             88 88 88 88  88888
             88_88_::_88_:88888
             88:::,::,:::::8888
             88`:::::::::'`8888
            .88  `::::'    8:88.
           8888            `8:888.
         .8888'             `888888.
        .8888:..  .::.  ...:'8888888:.
       .8888.'     :'     `'::`88:88888
      .8888        '         `.888:8888.
     888:8         .           888:88888
   .888:88        .:           888:88888:
   8888888.       ::           88:888888
   `.::.888.      ::          .88888888
  .::::::.888.    ::         :::`8888'.:.
 ::::::::::.888   '         .::::::::::::
 ::::::::::::.8    '      .:8::::::::::::.
.::::::::::::::.        .:888:::::::::::::
:::::::::::::::88:.__..:88888:::::::::::'
 `'.:::::::::::88888888888.88:::::::::'
       `':::_:' -- '' -'-' `':_::::'`
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
