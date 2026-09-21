require("mason").setup {
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },
}

local lspconfig = require "lspconfig"
require("mason-lspconfig").setup {
  ensure_installed = { "lua_ls" },
  automatic_enable = true,
  handlers = {
    function(server_name)
      if server_name == "jdtls" then
        return
      end
      lspconfig[server_name].setup {}
    end,
  },
}

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local opts = { buffer = args.buf, remap = false }

    local builtin = require "telescope.builtin"
    vim.keymap.set("n", "<leader>d", builtin.diagnostics, vim.tbl_extend("force", opts, { desc = "Show diagnostics" }))
    vim.keymap.set(
      "n",
      "grr",
      builtin.lsp_references,
      vim.tbl_extend("force", opts, { desc = "vim.lsp.buf.references()" })
    )

    vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, vim.tbl_extend("force", opts, { desc = "Signature help" }))
  end,
})

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } },
      workspace = {
        library = {
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.stdpath "config" .. "/lua"] = true,
        },
        checkThirdParty = false,
      },
      telemetry = { enable = false },
    },
  },
})

require("tiny-inline-diagnostic").setup {
  preset = "minimal",
  show_source = {
    enabled = true,
    if_many = true,
  },
  multilines = { enabled = true },
  show_all_diags_on_cursorline = true,
  show_diags_only_under_cursor = true,
}

require("conform").setup {
  formatters_by_ft = {
    lua = { "stylua" },
    rust = { "rustfmt" },
    java = { "palantir-java-format" },
    javascript = { "prettierd" },
    javascriptreact = { "prettierd" },
    typescript = { "prettierd" },
    typescriptreact = { "prettierd" },
    html = { "prettierd" },
    cs = { "csharpier" },
    python = { "ruff" },
    razor = { "razorstyle" },
    go = { "gofumpt" },
  },
  formatters = {
    razorstyle = {
      command = "razorstyle",
      args = { "fix", "$FILENAME" },
      stdin = false,
    },
  },
  format_on_save = {
    lsp_format = "fallback",
    timeout_ms = 500,
  },
}

vim.keymap.set("n", "<leader>fmt", function()
  require("conform").format()
end, { desc = "Format buffer" })
