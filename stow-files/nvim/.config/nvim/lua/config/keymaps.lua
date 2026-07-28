-- Leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- jj or jk to exit insert mode
vim.keymap.set("i", "jk", "<ESC>")
vim.keymap.set("i", "jj", "<ESC>")

-- Open Lazy
vim.keymap.set("n", "<leader>l", "<cmd>Lazy<cr>")

-- Telescope
vim.keymap.set("n", "<leader>t", "<cmd>Telescope<cr>")

-- Jump to config
vim.keymap.set('n', '<leader>fc', function()
    require('telescope.builtin').find_files({ cwd = vim.fn.stdpath('config') })
end)

-- LSP code actions
vim.keymap.set({"n", "x"}, "<leader>a", "<cmd>lua require('fastaction').code_action()<cr>")
vim.keymap.set({"n", "x"}, "<leader>ca", function()
    vim.lsp.buf.code_action({ apply = true })
end)

-- Paste over visual selection and retain paste buffer
vim.keymap.set("x", "<leader>p", "\"_dP")

-- Move cursor to centre of screen when scrolling
vim.keymap.set("n", "<C-d>", "<C-d>zz", { remap = true, silent = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { remap = true, silent = true })

-- Append semicolon to end of line
vim.keymap.set("n", "<c-;>", "A;<esc>")
vim.keymap.set("i", "<c-;>", "<esc>A;")

-- Append comma to end of line
vim.keymap.set("n", "<c-,>", "A,<esc>")
vim.keymap.set("i", "<c-,>", "<esc>A,")

-- Insert lines without entering insert mode
vim.keymap.set("n", "<M-o>", "o<Esc>")
vim.keymap.set("n", "<M-O>", "O<Esc>")

-- Alt+k/j to move line or visual selection up/down
vim.keymap.set("n", "<M-k>", "<cmd>m .-2<CR>==")
vim.keymap.set("n", "<M-j>", "<cmd>m .+1<CR>==")
vim.keymap.set("v", "<M-k>", ":m '<-2<CR>gv=gv", { silent = true })
vim.keymap.set("v", "<M-j>", ":m '>+1<CR>gv=gv", { silent = true })

-- Keep visual mode after indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Remove search highlighting with Escape
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<cr>", { silent = true })

-- Helper to feed keys safely in Lua
local function feed(keys)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keys, true, false, true), 'n', true)
end

-- Ctrl+Enter / Shift+Enter to make newline above/below in insert mode
local function insert_newline_below()
    feed("<Esc>o")
end

local function insert_newline_above()
    feed("<Esc>O")
end

vim.keymap.set('i', '<C-CR>', insert_newline_below, { desc = "Insert line below" })
vim.keymap.set('i', '<S-CR>', insert_newline_above, { desc = "Insert line above" })

vim.keymap.set("i", "<C-CR>", function()
    vim.cmd("stopinsert")
    insert_newline_below()
    vim.cmd("startinsert")
end)

vim.keymap.set("i", "<S-CR>", function()
    vim.cmd("stopinsert")
    insert_newline_above()
    vim.cmd("startinsert")
end)
