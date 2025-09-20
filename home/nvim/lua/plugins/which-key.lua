return {
  opts = {
    delay = 500,
  },
  keys = function()
    vim.keymap.set("n", "<leader>?", function()
      require("which-key").show({ global = false })
    end, { desc = "Keys?" })
  end,
}
