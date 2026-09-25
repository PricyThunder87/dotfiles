-- vim.pack has no `build` field: run the plugin's build.lua (lazy.nvim
-- convention) or `spec.data.build` after install/update. Must be registered
-- before vim.pack.add() to catch installs.
vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    if ev.data.kind ~= "install" and ev.data.kind ~= "update" then return end
    local build = ev.data.path .. "/build.lua"
    local run
    if vim.uv.fs_stat(build) then
      run = function() dofile(build) end
    elseif ev.data.spec.data and ev.data.spec.data.build then
      local shell = ev.data.spec.data.build
      run = function()
        local r = vim.system(vim.split(shell, " "), { cwd = ev.data.path, text = true }):wait()
        if r.code ~= 0 then error(shell .. " failed:\n" .. r.stderr) end
      end
    end
    if not run then return end
    local ok, err = pcall(run)
    if not ok then vim.notify(("%s build failed:\n%s"):format(ev.data.spec.name, err), vim.log.levels.ERROR) end
  end,
})

require "config.options"
require "config.keymaps"
require "config.colorscheme"

vim.pack.add {
  -- LSP
  { src = "https://github.com/saghen/blink.lib", name = "blink-lib" },
  { src = "https://github.com/saghen/blink.cmp", name = "blink-cmp" },
  { src = "https://github.com/williamboman/mason.nvim", name = "mason" },
  { src = "https://github.com/stevearc/conform.nvim", name = "conform" },
  { src = "https://github.com/neovim/nvim-lspconfig", name = "nvim-lspconfig" },
  { src = "https://github.com/ray-x/lsp_signature.nvim", name = "lsp_signature" },
  { src = "https://github.com/Chaitanyabsprip/fastaction.nvim", name = "fastaction" },
  { src = "https://github.com/williamboman/mason-lspconfig.nvim", name = "mason-lspconfig" },
  { src = "https://github.com/rachartier/tiny-inline-diagnostic.nvim", name = "tiny-inline-diagnostic" },

  -- Tree-sitter
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", name = "nvim-treesitter" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects", name = "nvim-treesitter-textobjects" },

  -- Editor
  { src = "https://github.com/uga-rosa/ccc.nvim", name = "ccc" },
  { src = "https://github.com/nvim-mini/mini.nvim", name = "mini" },
  { src = "https://github.com/tpope/vim-repeat", name = "vim-repeat" },
  { src = "https://github.com/CoreyKaylor/diffbandit.nvim", name = "diffbandit" },

  -- Terminal
  { src = "https://github.com/MunifTanjim/nui.nvim", name = "nui" },
  { src = "https://github.com/wr9dg17/essential-term.nvim", name = "essential-term" },

  -- Telescope
  { src = "https://github.com/nvim-lua/plenary.nvim", name = "plenary" },
  { src = "https://github.com/nvim-telescope/telescope.nvim", name = "telescope" },
  { src = "https://github.com/Slotos/telescope-lsp-handlers.nvim", name = "telescope-lsp-handlers" },
  {
    src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim",
    name = "telescope-fzf-native",
    data = { build = "make" },
  },
}

vim.pack.add({
  -- Language Specific
  -- C#
  { src = "https://github.com/GustavEikaas/easy-dotnet.nvim", name = "easy-dotnet" },
  -- Java
  { src = "https://github.com/mfussenegger/nvim-jdtls", name = "nvim-jdtls" },
  { src = "https://github.com/PricyThunder87/easy-java.nvim", name = "easy-java" },
  -- Markdown
  { src = "https://github.com/blackhat-7/vellum.nvim", name = "vellum" },
  -- SQL
  { src = "https://github.com/Kurren123/mssql.nvim", name = "mssql" },
  -- Web
  { src = "https://github.com/windwp/nvim-ts-autotag", name = "nvim-ts-autotag" },
  { src = "https://github.com/maxmellon/vim-jsx-pretty", name = "vim-jsx-pretty" },
}, { load = false })

require "plugins.lsp"
require "plugins.ccc"
require "plugins.mini"
require "plugins.autotag"
require "plugins.blink-cmp"
require "plugins.telescope"
require "plugins.diffbandit"
require "plugins.essential-term"
