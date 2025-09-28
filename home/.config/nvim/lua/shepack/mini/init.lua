return {
  {
    "nvim-mini/mini.nvim",
    commit = "228a8c34fae1d778e895ad06e4158f65e85828bc",
    config = function()
      require("shepack/mini/indentscope")
      require("shepack/mini/pairs")
    end,
  },
}
