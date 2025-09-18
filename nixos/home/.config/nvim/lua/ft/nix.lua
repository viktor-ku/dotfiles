return {
  pattern = { "*.nix" },
  filetypes = { "nix" },
  fmt = {
    cmd = { "alejandra", "-" },
  },
  lsp = {
    cmd = { "nil" },
    root_markers = { "flake.nix", ".git" },
  },
}
