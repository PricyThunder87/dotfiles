-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Telescope
vim.keymap.set("n", "<C-t>", ":Telescope<cr>", opts)

-- Code Runner
vim.keymap.set("n", "<F5>", ":RunCode<cr>", opts)

-- Hop
vim.keymap.set("n", "<Tab>", ":HopWord<cr>", opts)

-- Insert lines without entering insert mode
local function insert_line_above()
  local indent = vim.fn.indent(vim.fn.line("."))
  vim.fn.append(vim.fn.line(".") - 1, string.rep(" ", indent))
end

local function insert_line_below()
  local indent = vim.fn.indent(vim.fn.line("."))
  vim.fn.append(vim.fn.line("."), string.rep(" ", indent))
end

vim.keymap.set("n", "<M-O>", insert_line_above, opts)
vim.keymap.set("n", "<M-o>", insert_line_below, opts)

-- Alt+k/j to move line or visual selection up/down
vim.keymap.set("n", "<M-k>", ":m .-2<CR>==", opts)
vim.keymap.set("n", "<M-j>", ":m .+1<CR>==", opts)
vim.keymap.set("v", "<M-k>", ":<C-U>execute \"'<,'>move '<-2\"<CR>gv", opts)
vim.keymap.set("v", "<M-j>", ":<C-U>execute \"'<,'>move '>+1\"<CR>gv", opts)

-- H / L: beginning / end of line
vim.keymap.set("n", "H", "^", opts)
vim.keymap.set("n", "L", "$", opts)

-- Keep visual mode after indenting
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- Ctrl / Shift Enter: new line below / above (insert mode)
local function insert_newline_below()
  vim.cmd("normal! o")
end

local function insert_newline_above()
  vim.cmd("normal! O")
end

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
