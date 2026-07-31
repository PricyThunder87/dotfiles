require('config.options')
require('config.keymaps')
require('config.colorscheme')

vim.pack.add({
    -- LSP
    { src = 'https://github.com/neovim/nvim-lspconfig', name = 'nvim-lspconfig' },
    { src = 'https://github.com/williamboman/mason.nvim', name = 'mason' },
    { src = 'https://github.com/williamboman/mason-lspconfig.nvim', name = 'mason-lspconfig' },
    { src = 'https://github.com/ray-x/lsp_signature.nvim', name = 'lsp_signature' },
    { src = 'https://github.com/nvim-treesitter/nvim-treesitter', name = 'nvim-treesitter' },
    { src = 'https://github.com/Chaitanyabsprip/fastaction.nvim', name = 'fastaction' },
    { src = 'https://github.com/rachartier/tiny-inline-diagnostic.nvim', name = 'tiny-inline-diagnostic' },

    -- Editor
    { src = 'https://github.com/nvim-mini/mini.nvim', name = 'mini' },
    { src = 'https://github.com/tpope/vim-repeat', name = 'vim-repeat' },
    { src = 'https://github.com/brenoprata10/nvim-highlight-colors', name = 'nvim-highlight-colors' },
    { src = 'https://github.com/brenoprata10/nvim-highlight-colors', name = 'nvim-highlight-colors' },

    -- Telescope
    { src = 'https://github.com/nvim-lua/plenary.nvim', name = 'plenary' },
    { src = 'https://github.com/nvim-telescope/telescope.nvim', name = 'telescope' },
    { src = 'https://github.com/nvim-telescope/telescope-fzf-native.nvim', name = 'telescope-fzf-native', build = 'make' },
    { src = 'https://github.com/Slotos/telescope-lsp-handlers.nvim', name = 'telescope-lsp-handlers' },

    -- Language Specific
    -- C#
    { src = 'https://github.com/GustavEikaas/easy-dotnet.nvim', name = 'easy-dotnet' },
    -- Web
    { src = 'https://github.com/windwp/nvim-ts-autotag', name = 'nvim-ts-autotag' },
    { src = 'https://github.com/maxmellon/vim-jsx-pretty', name = 'vim-jsx-pretty' },
    -- Java
    { src = 'https://github.com/mfussenegger/nvim-jdtls', name = 'nvim-jdtls' },
    -- Markdown
    { src = 'https://github.com/MeanderingProgrammer/render-markdown.nvim', name = 'render-markdown' },
    -- SQL
    { src = 'https://github.com/Kurren123/mssql.nvim', name = 'mssql' },
})

require('plugins.lsp')
require('plugins.mini')
