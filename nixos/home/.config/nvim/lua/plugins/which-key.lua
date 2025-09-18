return {
  config = function()
    local opts = {
      preset = "classic",
      delay = 500,
    }

    require("which-key").setup(opts)
  end,
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Keys?",
    },
  },
}
