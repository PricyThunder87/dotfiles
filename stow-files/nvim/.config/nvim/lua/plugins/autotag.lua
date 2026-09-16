require("nvim-ts-autotag").setup {
  opts = {
    -- Enable defaults (close tags, rename tags, etc.)
    enable_close = true,
    enable_rename = true,
    enable_close_on_slash = false,
  },
  -- Optional: Per-filetype fine-tuning
  per_filetype = {
    ["html"] = {
      enable_close = true,
    },
    ["javascriptreact"] = {
      enable_close = true,
    },
    ["typescriptreact"] = {
      enable_close = true,
    },
  },
}
