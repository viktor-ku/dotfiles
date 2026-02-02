return {
  "tinted-theming/tinted-nvim",
  commit = "0347c54827694e85f4880233eefd71be3978e439",
  config = function()
    local theme = "base24-ayu-light"
    require("tinted-colorscheme").setup(theme)
    pcall(vim.cmd.colorscheme, theme)
  end,
}
