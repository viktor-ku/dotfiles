return {
  "folke/trouble.nvim",
  commit = "76030c5542c5d132aeeb467ca0ab370f3f79a697",
  config = function()
    require("trouble").setup({
      auto_close = true,
    })

    vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>")
    vim.keymap.set("n", "<leader>xn", function()
      require("trouble").next({ jump = true, skip_groups = true })
    end)
    vim.keymap.set("n", "<leader>xp", function()
      require("trouble").prev({ jump = true, skip_groups = true })
    end)
  end,
}
