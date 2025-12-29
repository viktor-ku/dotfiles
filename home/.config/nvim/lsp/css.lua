return {
  cmd = { "css-language-server" },
  filetypes = { "css", "scss", "less" },
  init_options = { provideFormatter = true },
  root_markers = { "package.json", ".git" },
  settings = {
    css = { validate = true },
    scss = { validate = true },
    less = { validate = true },
  },
}
