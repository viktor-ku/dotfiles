return {
  "folke/which-key.nvim",
  commit = "3aab2147e74890957785941f0c1ad87d0a44c15a",
  config = function()
    require("which-key").setup({
      delay = 500,
    })

    vim.keymap.set("n", "<leader>?", function()
      require("which-key").show({ global = false })
    end, { desc = "Keys?" })
  end,
}
