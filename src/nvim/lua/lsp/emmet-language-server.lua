return require("lsp_setup")(function()
  --- @type vim.lsp.Config
  local config = {
    cmd = { "emmet-language-server", "--stdio" },
    filetypes = {
      "astro",
      "css",
      "eruby",
      "html",
      "htmlangular",
      "htmldjango",
      "javascriptreact",
      "less",
      "pug",
      "sass",
      "scss",
      "svelte",
      "templ",
      "typescriptreact",
      "vue",
    },
    root_markers = { ".git" },
  }

  return config
end)
