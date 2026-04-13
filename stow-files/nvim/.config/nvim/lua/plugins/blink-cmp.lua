return {
    'saghen/blink.cmp',
    version = '*',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
	keymap = { preset = 'super-tab' },
	appearance = { nerd_font_variant = 'mono' },
	completion = { documentation = { auto_show = false } },
	sources = { default = { 'lsp', 'path', 'snippets' }, },
	fuzzy = { implementation = "prefer_rust_with_warning" },
	cmdline = {
	    keymap = { preset = 'inherit' },
	    completion = { menu = { auto_show = true } }
	}
    },
    opts_extend = { "sources.default" }
}
