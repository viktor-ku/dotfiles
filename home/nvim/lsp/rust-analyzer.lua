return {
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
