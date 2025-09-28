-- Specify your plugin according to this spec:
-- https://github.com/lewis6991/pckr.nvim?tab=readme-ov-file#specifying-plugins
return {
  "folke/trouble.nvim",
  commit = "f176232e7759c4f8abd923c21e3e5a5c76cd6837",
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
