-- Specify your plugin according to this spec:
-- https://github.com/lewis6991/pckr.nvim?tab=readme-ov-file#specifying-plugins
return {
  "HiPhish/rainbow-delimiters.nvim",
  commit = "687ef75fdbd497eabc9eea92b52e7b4d403b3319",
  config = function()
    require("rainbow-delimiters.setup").setup({})
  end,
}
