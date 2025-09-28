-- Specify your plugin according to this spec:
-- https://github.com/lewis6991/pckr.nvim?tab=readme-ov-file#specifying-plugins
return {
  "folke/which-key.nvim",
  commit = "904308e6885bbb7b60714c80ab3daf0c071c1492",
  config = function()
    require("which-key").setup({
      delay = 500,
    })

    vim.keymap.set("n", "<leader>?", function()
      require("which-key").show({ global = false })
    end, { desc = "Keys?" })
  end,
}
