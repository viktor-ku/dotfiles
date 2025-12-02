-- https://github.com/nvim-mini/mini.nvim/commits/main/
return {
  {
    "nvim-mini/mini.nvim",
    commit = "dca98843fab66d080779cd973e7139e258ff164c",
    config = function()
      require("shepack/mini/indentscope")
      require("shepack/mini/pairs")
    end,
  },
}
