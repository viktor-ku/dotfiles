return require("lsp_setup")(function()
  --- @type vim.lsp.Config
  local config = {
    cmd = { "marksman", "server" },
    filetypes = { "markdown", "markdown.mdx" },
    root_markers = { ".marksman.toml", ".git" },
  }

  return config
end)
