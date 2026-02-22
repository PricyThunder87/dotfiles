-- Leader key
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Open Lazy
vim.keymap.set("n", "<leader>l", ":Lazy<cr>")

-- Telescope
vim.keymap.set("n", "<C-t>", ":Telescope<cr>", opts)

-- LSP code actions
vim.keymap.set({"n", "x"}, "<leader>a", ":lua require('fastaction').code_action()<CR>", opts)
vim.keymap.set({"n", "x"}, "<leader>ca", function()
    vim.lsp.buf.code_action({ apply = true })
end, opts)

-- Move cursor to centre of screen when scrolling
vim.keymap.set("n", "<C-d>", "<C-d>zz", { remap = true, silent = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { remap = true, silent = true })

-- Shortcuts to append semicolon/comma/brace to end of line
-- ;
vim.keymap.set("n", "<C-;>", "A;<Esc>", opts)
vim.keymap.set("i", "<C-;>", "<Esc>A;", opts)
-- ,
vim.keymap.set("n", "<C-,>", "A,<Esc>", opts)
vim.keymap.set("i", "<C-,>", "<Esc>A,", opts)

-- Insert lines without entering insert mode
vim.keymap.set("n", "<M-o>", "o<Esc>", opts)
vim.keymap.set("n", "<M-O>", "O<Esc>", opts)

-- Alt+k/j to move line or visual selection up/down
vim.keymap.set("n", "<M-k>", ":m .-2<CR>==", opts)
vim.keymap.set("n", "<M-j>", ":m .+1<CR>==", opts)
vim.keymap.set("v", "<M-k>", ":<C-U>execute \"'<,'>move '<-2\"<CR>gv", opts)
vim.keymap.set("v", "<M-j>", ":<C-U>execute \"'<,'>move '>+1\"<CR>gv", opts)

-- H / L: beginning / end of line
vim.keymap.set({ "n", "v" }, "H", "^", opts)
vim.keymap.set({ "n", "v" }, "L", "$", opts)

-- Keep visual mode after indenting
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

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
end, opts)

vim.keymap.set("i", "<S-CR>", function()
    vim.cmd("stopinsert")
    insert_newline_above()
    vim.cmd("startinsert")
end, opts)

vim.keymap.set("i", "jk", "<ESC>")
