return {
  config = function()
    --
  end,
  keys = function()
    vim.keymap.set({ "n", "x", "o" }, "s", function()
      require("flash").jump()
    end)

    vim.keymap.set({ "n", "x", "o" }, "S", function()
      require("flash").treesitter()
    end)
  end,
}
