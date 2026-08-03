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
  delay = { completion = 0, info = 0, signature = 50 },
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
vim.keymap.set("n", "<leader>fc", function()
  require("mini.pick").builtin.files(nil, {
    source = {
      cwd = vim.fn.stdpath "config",
      name = "Neovim Config",
    },
  })
end, { desc = "Find files in Neovim config" })
