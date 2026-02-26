-- Leader key
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Open Lazy
vim.keymap.set("n", "<leader>l", "<cmd>Lazy<cr>")

-- Telescope
vim.keymap.set("n", "<C-t>", "<cmd>Telescope<cr>")

-- LSP code actions
vim.keymap.set({"n", "x"}, "<leader>a", "<cmd>lua require('fastaction').code_action()<cr>")
vim.keymap.set({"n", "x"}, "<leader>ca", function()
    vim.lsp.buf.code_action({ apply = true })
end)

-- Move cursor to centre of screen when scrolling
vim.keymap.set("n", "<C-d>", "<C-d>zz", { remap = true, silent = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { remap = true, silent = true })

-- Shortcuts to append semicolon/comma/brace to end of line
-- ;
vim.keymap.set("n", "<C-;>", "A;<Esc>")
vim.keymap.set("i", "<C-;>", "<Esc>A;")
-- ,
vim.keymap.set("n", "<C-,>", "A,<Esc>")
vim.keymap.set("i", "<C-,>", "<Esc>A,")

-- Insert lines without entering insert mode
vim.keymap.set("n", "<M-o>", "o<Esc>")
vim.keymap.set("n", "<M-O>", "O<Esc>")

-- Alt+k/j to move line or visual selection up/down
vim.keymap.set("n", "<M-k>", "<cmd>m .-2<CR>==")
vim.keymap.set("n", "<M-j>", "<cmd>m .+1<CR>==")
vim.keymap.set("v", "<M-k>", ":m '<-2<CR>gv=gv", { silent = true })
vim.keymap.set("v", "<M-j>", ":m '>+1<CR>gv=gv", { silent = true })

-- H / L: beginning / end of line
vim.keymap.set({ "n", "v" }, "H", "^")
vim.keymap.set({ "n", "v" }, "L", "$")

-- Keep visual mode after indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Remove search highlighting with Escape
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<cr>", { silent = true })

-- Helper to feed keys safely in Lua
local function feed(keys)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keys, true, false, true), 'n', true)
end

-- Ctrl + Enter: New line below with proper indent
local function insert_newline_below()
    feed("<Esc>o")
end

-- Shift + Enter: New line above with proper indent
local function insert_newline_above()
    feed("<Esc>O")
end

-- Example Keybindings (adjust for your specific terminal/OS)
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

vim.keymap.set("i", "jk", "<ESC>")
