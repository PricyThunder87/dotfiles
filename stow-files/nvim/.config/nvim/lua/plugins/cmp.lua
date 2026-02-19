return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"L3MON4D3/LuaSnip",
	"saadparwaiz1/cmp_luasnip",

	-- Copilot
	"zbirenbaum/copilot.lua",
	"zbirenbaum/copilot-cmp",
    },
    config = function()
	local cmp = require("cmp")
	local luasnip = require("luasnip")

	cmp.setup({
	    preselect = cmp.PreselectMode.None,
	    completion = {
		completeopt = "menu,menuone,noselect,noinsert",
	    },

	    snippet = {
		expand = function(args)
		    luasnip.lsp_expand(args.body)
		end,
	    },

	    mapping = cmp.mapping.preset.insert({
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-K>"] = cmp.mapping.confirm({ select = false }),

		["<Tab>"] = cmp.mapping(function(fallback)
		    if cmp.visible() then
			cmp.select_next_item()
		    elseif luasnip.expand_or_jumpable() then
			luasnip.expand_or_jump()
		    else
			fallback()
		    end
		end, { "i", "s" }),

		["<S-Tab>"] = cmp.mapping(function(fallback)
		    if cmp.visible() then
			cmp.select_prev_item()
		    elseif luasnip.jumpable(-1) then
			luasnip.jump(-1)
		    else
			fallback()
		    end
		end, { "i", "s" }),
	    }),

	    sources = cmp.config.sources({
		{ name = "copilot",  priority = 1000 },
		{ name = "nvim_lsp", priority = 900 },
		{ name = "luasnip",  priority = 800 },
		{ name = "path",     priority = 700 },
	    }),

	    sorting = {
		priority_weight = 2,
		comparators = {
		    cmp.config.compare.offset,
		    cmp.config.compare.exact,
		    cmp.config.compare.score,
		    require("copilot_cmp.comparators").prioritize,
		    cmp.config.compare.kind,
		    cmp.config.compare.sort_text,
		    cmp.config.compare.length,
		    cmp.config.compare.order,
		},
	    },
	})
    end
}
