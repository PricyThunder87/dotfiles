return {
    "kawre/neotab.nvim",
    event = "InsertEnter",
    opts = {
	tabkey = "<C-l>",
	reverse_key = "<C-h>",
	act_as_tab = false,
	behavior = "nested", ---@type ntab.behavior
	pairs = { ---@type ntab.pair[]
	    { open = "(", close = ")" },
	    { open = "[", close = "]" },
	    { open = "{", close = "}" },
	    { open = "'", close = "'" },
	    { open = '"', close = '"' },
	    { open = "`", close = "`" },
	    { open = "<", close = ">" },
	},
	exclude = {},
	smart_punctuators = {
	    enabled = true,
	    semicolon = {
		enabled = true,
		ft = { "cs", "c", "cpp", "java" },
	    },
	    escape = {
		enabled = false,
		triggers = {}, ---@type table<string, ntab.trigger>
	    },
	},
    }
}
