return require("lsp_setup")(function()
  --- @type vim.lsp.Config
  local config = {
    cmd = { "vscode-css-language-server", "--stdio" },
    filetypes = { "css", "scss", "less" },
    init_options = { provideFormatter = true }, -- needed to enable formatting capabilities
    root_markers = { "package.json", ".git" },
    settings = {
      css = { validate = true },
      scss = { validate = true },
      less = { validate = true },
    },
  }

  return config
end)
