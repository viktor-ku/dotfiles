return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    local bufferline = require("bufferline")

    bufferline.setup({
      options = {
        style_preset = bufferline.style_preset.minimal,
        themable = true,
        numbers = "none",
        diagnostics = "nvim_lsp",
        color_icons = true,
      },
    })
  end,
}
