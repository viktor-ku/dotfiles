-- Specify your plugin according to this spec:
-- https://github.com/lewis6991/pckr.nvim?tab=readme-ov-file#specifying-plugins
return {
  "nvim-tree/nvim-web-devicons",
  commit = "f6b0920f452bfd7595ee9a9efe5e1ae78e0e2997",
  config = function()
    require("nvim-web-devicons").setup({})
  end,
}
