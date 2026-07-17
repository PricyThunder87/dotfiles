-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
    pattern = "*",
    callback = function()
	vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
    end,
})

-- Use absolute line numbers when in insert mode
vim.api.nvim_create_autocmd("InsertEnter", {
    callback = function()
	vim.opt.relativenumber = false
    end,
})

vim.api.nvim_create_autocmd("InsertLeave", {
    callback = function()
	vim.opt.relativenumber = true
	trim_trailing_whitespaces()
    end,
})

-- Set shift width to 2 in HTML-adjacent filetypes
local leet_indent = vim.api.nvim_create_augroup("LeetIndent", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  group = leet_indent,
  pattern = { "typescriptreact", "javascriptreact", "html", "css", "json" },
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.expandtab = true -- Converts tabs to spaces
  end,
})

-- Use Telescope for LSP actions
vim.api.nvim_create_autocmd({"LspAttach"}, {
    callback = function(args)
	local opts = { buffer = args.buf }
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to definition" }))
	vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, vim.tbl_extend("force", opts, { desc = "Go to references"}))
    end
})

-- Delete all trailing whitespaces in a file if it's not binary nor a diff
-- This is called in the InsertLeave block above
function _G.trim_trailing_whitespaces()
    if not vim.o.binary and vim.o.filetype ~= 'diff' then
        local current_view = vim.fn.winsaveview()
        vim.cmd([[keeppatterns %s/\s\+$//e]])
        vim.fn.winrestview(current_view)
    end
end

-- Disable automatic comment extension on new line
vim.api.nvim_create_autocmd('BufWinEnter', {
    command = 'set formatoptions-=cro',
})
