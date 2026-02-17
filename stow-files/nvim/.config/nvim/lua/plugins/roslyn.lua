return {
  "seblyng/roslyn.nvim",
  ft = { "cs", "razor" },
  opts = {
    -- Points to the Mason-installed binary
    exe = vim.fn.stdpath("data") .. "/mason/bin/roslyn-language-server",
    args = {
      "--logLevel=Information",
      "--extensionLogDirectory=" .. vim.fn.stdpath("cache") .. "/roslyn-logs",
    },
    config = {
      -- This is where the magic happens for performance
      on_attach = function(client, bufnr)
        -- Razor files send a flood of tokens that freeze Neovim. 
        -- Disabling this usually restores 60fps typing.
        if vim.bo[bufnr].filetype == "razor" then
          client.server_capabilities.semanticTokensProvider = nil
        end
      end,
      settings = {
        ["csharp"] = {
          -- Reduces background indexing load
          background_analysis = {
            dotnet_analyzer_diagnostics_scope = "openFiles",
            dotnet_compiler_diagnostics_scope = "openFiles",
          },
        },
        ["razor"] = {
          enabled = true,
        },
      },
    },
  },
}
