return {
  config = function()
    local opts = {
      auto_close = true,
    }

    require("trouble").setup(opts)
  end,
  keys = {
    {
      "<leader>xx",
      "<cmd>Trouble diagnostics toggle<cr>",
      desc = "Diagnostics (Trouble)",
    },
    {
      "<leader>xn",
      function()
        require("trouble").next({ jump = true, skip_groups = true })
      end,
      desc = "Jump next",
    },
    {
      "<leader>xp",
      function()
        require("trouble").prev({ jump = true, skip_groups = true })
      end,
      desc = "Jump previous",
    },
  },
}
