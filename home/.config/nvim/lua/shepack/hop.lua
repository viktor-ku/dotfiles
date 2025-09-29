-- Specify your plugin according to this spec:
-- https://github.com/lewis6991/pckr.nvim?tab=readme-ov-file#specifying-plugins
return {
  "smoka7/hop.nvim",
  commit = "707049feaca9ae65abb3696eff9aefc7879e66aa",
  config = function()
    require("hop").setup({
      keys = "etovxqpdygfblzhckisuran",
    })

    vim.keymap.set({ "n", "x", "o" }, "s", function()
      require("hop").hint_char1()
    end)
  end,
}
