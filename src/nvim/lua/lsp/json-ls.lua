return require("lsp_setup")(function()
  --- @type vim.lsp.Config
  local config = {
    cmd = { "vscode-json-language-server", "--stdio" },
    filetypes = { "json", "jsonc" },
    init_options = {
      provideFormatter = true,
    },
    root_markers = { ".git" },
  }

  return config
end)
