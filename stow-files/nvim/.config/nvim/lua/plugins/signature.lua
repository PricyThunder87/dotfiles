return {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function()
	require("lsp_signature").setup({
	    bind = true, -- This is mandatory, otherwise border config won't get registered.
	    floating_window_above_cur = true,
	    handler_opts = {
		border = "rounded",
	    },
	    always_trigger = true,
	    auto_close_after = nil,
	})
    end
}
