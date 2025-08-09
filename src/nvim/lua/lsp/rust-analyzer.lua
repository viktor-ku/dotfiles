return require("lsp_setup")(function()
  --- @type vim.lsp.Config
  local config = {
    cmd = { "rust-analyzer" },
    filetypes = { "rust" },
    root_markers = { "Cargo.toml", ".git" },
    settings = {
      ["rust-analyzer"] = {
        lens = {
          enable = true,
          methodReferences = true,
          references = true,
        },
        inlayHints = {
          typeHints = true,
          parameterHints = true,
          chainingHints = true,
        },
      },
    },
    capabilities = {
      experimental = {},
      textDocument = {
        completion = {
          completionItem = { snippetSupport = true },
        },
        codeLens = {
          dynamicRegistration = true,
        },
        semanticTokens = {
          full = true,
        },
      },
    },
  }

  return config
end)
