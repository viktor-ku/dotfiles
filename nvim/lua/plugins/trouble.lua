return {
  "folke/trouble.nvim",
  opts = {
    auto_close = true,
  },
  cmd = "Trouble",
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
