require("mini.ai").setup()
require("mini.align").setup()
require("mini.cmdline").setup()
require("mini.diff").setup()
require("mini.extra").setup()
require("mini.git").setup()
require("mini.icons").setup()
require("mini.jump").setup()
require("mini.move").setup()
require("mini.notify").setup()
require("mini.pairs").setup()
require("mini.pick").setup()
require("mini.splitjoin").setup()
require("mini.starter").setup()
require("mini.surround").setup()
require("mini.tabline").setup()

require("mini.completion").setup {
  delay = { completion = 0, info = 0, signature = 0 },
}

local imap_expr = function(lhs, rhs)
  vim.keymap.set("i", lhs, rhs, { expr = true })
end

imap_expr("<Tab>", [[pumvisible() ? "\<C-n>" : "\<Tab>"]])
imap_expr("<S-Tab>", [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]])

require("mini.files").setup {
  windows = { max_number = 3, preview = true, width_preview = 75 },
}

require "plugins.mini-files-git-integration"

vim.api.nvim_create_autocmd("User", {
  pattern = "MiniFilesWindowUpdate",
  callback = function(args)
    vim.wo[args.data.win_id].number = true
    vim.wo[args.data.win_id].relativenumber = true
  end,
})

local mini_files = require "mini.files"

-- Set focused directory as current working directory
local set_cwd = function()
  local path = (mini_files.get_fs_entry() or {}).path
  if path == nil then
    return vim.notify "Cursor is not on valid entry"
  end
  vim.fn.chdir(vim.fs.dirname(path))
  vim.notify("Set working directory to " .. vim.fn.getcwd())
end

-- Yank in register full path of entry under cursor
local yank_path = function()
  local path = (mini_files.get_fs_entry() or {}).path
  if path == nil then
    return vim.notify "Cursor is not on valid entry"
  end
  vim.fn.setreg(vim.v.register, path)
  vim.notify("Yanked directory " .. path)
end

vim.api.nvim_create_autocmd("User", {
  pattern = "MiniFilesBufferCreate",
  callback = function(args)
    local b = args.data.buf_id
    vim.keymap.set("n", "g~", set_cwd, { buffer = b, desc = "Set cwd" })
    vim.keymap.set("n", "gy", yank_path, { buffer = b, desc = "Yank path" })
  end,
})

require("mini.indentscope").setup {
  draw = {
    delay = 0,
    animation = function()
      return 0
    end,
  },
}

vim.keymap.set("n", "<leader>e", "<cmd>lua MiniFiles.open()<cr>", { desc = "Launch Mini.Files" })
vim.keymap.set("n", "<leader>ff", "<cmd>Pick files<cr>", { desc = "Find files current directory" })

vim.keymap.set("n", "<leader>fZ", function()
  local current_path = vim.uv.fs_realpath(vim.fn.expand "%:p:h")
  require("mini.pick").builtin.grep_live(nil, {
    source = {
      cwd = current_path,
      name = current_path,
    },
  })
end, { desc = "Live grep in current directory" })

vim.keymap.set("n", "<leader>fz", function()
  local current_path = vim.fn.getcwd()
  require("mini.pick").builtin.grep_live(nil, {
    source = {
      cwd = current_path,
      name = current_path,
    },
  })
end, { desc = "Live grep in current directory" })

vim.keymap.set("n", "<leader>fc", function()
  require("mini.pick").builtin.files(nil, {
    source = {
      cwd = vim.fn.stdpath "config",
      name = "Neovim Config",
    },
  })
end, { desc = "Find files in Neovim config" })
