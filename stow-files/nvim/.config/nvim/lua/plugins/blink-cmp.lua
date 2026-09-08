local cmp = require "blink.cmp"
cmp.build():pwait()

cmp.setup {
  completion = {
    keyword = { range = "full" },
    list = { selection = { preselect = false, auto_insert = false } },
    ghost_text = { enabled = true },
  },
  sources = {
    default = { "lsp", "path", "snippets" },
  },
  signature = { enabled = true },
  cmdline = {
    keymap = { preset = "inherit" },
    completion = {
      list = { selection = { preselect = false, auto_insert = true } },
      menu = { auto_show = true },
      ghost_text = { enabled = true },
    },
  },
  keymap = {
    preset = "none",
    ["<Tab>"] = { "select_next" },
    ["<S-Tab>"] = { "select_prev" },
    ["<C-n>"] = { "select_next" },
    ["<C-p>"] = { "select_prev" },
    ["<C-y>"] = { "select_and_accept" },
    ["<C-Space>"] = { "select_and_accept" },
  },
}
