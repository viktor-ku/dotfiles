return {
  "folke/which-key.nvim",
  commit = "b4177e3eaf15fe5eb8357ebac2286d488be1ed00",
  config = function()
    require("which-key").setup({
      delay = 500,
    })

    vim.keymap.set("n", "<leader>?", function()
      require("which-key").show({ global = false })
    end, { desc = "Keys?" })
  end,
}
