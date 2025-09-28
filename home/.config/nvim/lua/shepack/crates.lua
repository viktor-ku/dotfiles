-- Specify your plugin according to this spec:
-- https://github.com/lewis6991/pckr.nvim?tab=readme-ov-file#specifying-plugins
return {
  "saecki/crates.nvim",
  commit = "ac9fa498a9edb96dc3056724ff69d5f40b898453",
  config = function()
    require("crates").setup()
  end,
}
