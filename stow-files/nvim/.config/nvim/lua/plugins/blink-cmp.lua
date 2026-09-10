local cmp = require "blink.cmp"
cmp.build():pwait()

cmp.setup {
  completion = {
    keyword = { range = "full" },
    list = { selection = { preselect = false, auto_insert = true } },
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
    ["<Tab>"] = { "select_next", "fallback" },
    ["<S-Tab>"] = { "select_prev", "fallback" },
    ["<C-n>"] = { "select_next", "fallback" },
    ["<C-p>"] = { "select_prev", "fallback" },
    ["<C-y>"] = { "select_and_accept", "fallback" },
    ["<C-Space>"] = { "select_and_accept", "fallback" },
  },
}
