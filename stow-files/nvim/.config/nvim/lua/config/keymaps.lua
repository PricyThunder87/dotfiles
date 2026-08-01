-- Leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- jj or jk to exit insert mode
vim.keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode (jk)" })
vim.keymap.set("i", "jj", "<ESC>", { desc = "Exit insert mode (jj)" })

-- Close buffer
vim.keymap.set("n", "<leader>bd", "<cmd>bd<cr>", { desc = "Close current buffer" })
vim.keymap.set("n", "<leader>bo", function()
  local current = vim.api.nvim_get_current_buf()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if buf ~= current and vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buflisted then
      vim.api.nvim_buf_delete(buf, { force = false })
    end
  end
end, { desc = "Close all other buffers" })

-- Paste over visual selection and retain paste buffer
vim.keymap.set("x", "<leader>p", "'_dP", { desc = "Paste over selection without overwriting register" })

-- Move cursor to centre of screen when scrolling
vim.keymap.set("n", "<C-d>", "<C-d>zz", { remap = true, silent = true, desc = "Scroll down and center cursor" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { remap = true, silent = true, desc = "Scroll up and center cursor" })

-- Append semicolon to end of line
vim.keymap.set("n", "<c-;>", "A;<esc>", { desc = "Append semicolon to end of line" })
vim.keymap.set("i", "<c-;>", "<esc>A;", { desc = "Append semicolon to end of line (insert mode)" })

-- Append comma to end of line
vim.keymap.set("n", "<c-,>", "A,<esc>", { desc = "Append comma to end of line" })
vim.keymap.set("i", "<c-,>", "<esc>A,", { desc = "Append comma to end of line (insert mode)" })

-- Insert lines without entering insert mode
vim.keymap.set("n", "<M-o>", "o<Esc>", { desc = "Insert line below without entering insert mode" })
vim.keymap.set("n", "<M-O>", "O<Esc>", { desc = "Insert line above without entering insert mode" })

-- Keep visual mode after indenting
vim.keymap.set("v", "<", "<gv", { desc = "Indent left and keep selection" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and keep selection" })

-- Remove search highlighting with Escape
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<cr>", { silent = true, desc = "Clear search highlighting" })
