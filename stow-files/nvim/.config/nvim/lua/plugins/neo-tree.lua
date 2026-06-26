return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
	"nvim-lua/plenary.nvim",
	"MunifTanjim/nui.nvim",
	"nvim-tree/nvim-web-devicons",
    },
    lazy = false,
    config = function()
	require("neo-tree").setup({
	    filesystem = {
		group_empty_dirs = true,
		filtered_items = {
		    hide_dotfiles = false,
		},
		window = {
		    mappings = {
			["l"] = {
			    function(state)
				local node = state.tree:get_node()
				if node.type == "directory" then
				    if not node:is_expanded() then
					require("neo-tree.sources.filesystem.commands").toggle_node(state)
				    else
					vim.cmd("normal! j")
				    end
				else
				    require("neo-tree.sources.filesystem.commands").open(state)
				end
			    end,
			    desc = "Open directory or file",
			},
			["h"] = {
			    function(state)
				local node = state.tree:get_node()
				if node.type == "directory" and node:is_expanded() then
				    require("neo-tree.sources.filesystem.commands").toggle_node(state)
				else
				    require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
				end
			    end,
			    desc = "Close directory or go to parent",
			},
		    },
		},
	    },
	})
	vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<cr>")
    end
}
