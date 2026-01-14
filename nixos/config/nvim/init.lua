-- Preferences
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.ignorecase = true

vim.api.nvim_create_autocmd("InsertEnter", {
  callback = function()
    vim.opt.relativenumber = false
  end,
})

vim.api.nvim_create_autocmd("InsertLeave", {
  callback = function()
    vim.opt.relativenumber = true
  end,
})

-- Keybind helper
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Ctrl+Shift+C to copy to clipboard (insert mode)
map("i", "<C-S-C>", '<Esc>"+y`^', opts)

-- Shift+Arrow to select text (insert mode)
map("i", "<S-Left>",  "<C-O>v<Left>",  opts)
map("i", "<S-Right>", "<C-O>v<Right>", opts)
map("i", "<S-Up>",    "<C-O>v<Up>",    opts)
map("i", "<S-Down>",  "<C-O>v<Down>",  opts)

-- Insert line above / below without entering insert mode
local function insert_line_above()
  local indent = vim.fn.indent(vim.fn.line("."))
  vim.fn.append(vim.fn.line(".") - 1, string.rep(" ", indent))
end

local function insert_line_below()
  local indent = vim.fn.indent(vim.fn.line("."))
  vim.fn.append(vim.fn.line("."), string.rep(" ", indent))
end

map("n", "<M-O>", insert_line_above, opts)
map("n", "<M-o>", insert_line_below, opts)

-- Alt+k / Alt+j: move line or visual selection
map("n", "<M-k>", ":m .-2<CR>==", opts)
map("n", "<M-j>", ":m .+1<CR>==", opts)
map("v", "<M-k>", ":<C-U>execute \"'<,'>move '<-2\"<CR>gv", opts)
map("v", "<M-j>", ":<C-U>execute \"'<,'>move '>+1\"<CR>gv", opts)

-- H / L: beginning / end of line
map("n", "H", "^", opts)
map("n", "L", "$", opts)

-- Keep visual mode after indenting
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)

-- Ctrl / Shift Enter: new line below / above (insert mode)
local function insert_newline_below()
  local indent = vim.fn.indent(vim.fn.line("."))
  vim.fn.append(vim.fn.line("."), string.rep(" ", indent))
  vim.cmd("normal! j0")
end

local function insert_newline_above()
  local indent = vim.fn.indent(vim.fn.line("."))
  vim.fn.append(vim.fn.line(".") - 1, string.rep(" ", indent))
  vim.cmd("normal! k0")
end

map("i", "<C-CR>", function()
  vim.cmd("stopinsert")
  insert_newline_below()
  vim.cmd("startinsert")
end, opts)

map("i", "<S-CR>", function()
  vim.cmd("stopinsert")
  insert_newline_above()
  vim.cmd("startinsert")
end, opts)
