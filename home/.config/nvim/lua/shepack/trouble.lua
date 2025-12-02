return {
  "folke/trouble.nvim",
  commit = "bd67efe408d4816e25e8491cc5ad4088e708a69a",
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
