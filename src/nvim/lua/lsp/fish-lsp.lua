return require("lsp_setup")(function()
  --- @type vim.lsp.Config
  local config = {
    cmd = { "fish-lsp", "start" },
    filetypes = { "fish" },
    root_markers = { "config.fish", ".git" },
  }

  return config
end)
