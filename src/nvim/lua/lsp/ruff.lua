return require("lsp_setup")(function()
  --- @type vim.lsp.Config
  local config = {
    cmd = { "ruff", "server" },
    filetypes = { "python" },
    root_markers = { "pyproject.toml", "ruff.toml", ".ruff.toml", ".git" },
    settings = {},
  }

  return config
end)
