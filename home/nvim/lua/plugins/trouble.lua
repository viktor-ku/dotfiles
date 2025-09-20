return {
  opts = {
    auto_close = true,
  },
  config = function(opts)
    require("trouble").setup(opts)
  end,
  keys = function()
    vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>")
    vim.keymap.set("n", "<leader>xn", function()
      require("trouble").next({ jump = true, skip_groups = true })
    end)
    vim.keymap.set("n", "<leader>xp", function()
      require("trouble").prev({ jump = true, skip_groups = true })
    end)
  end,
}
