local function my_touch()
  vim.api.nvim_set_hl(0, "Comment", { fg = "#9A89A1", italic = true })
  vim.api.nvim_set_hl(0, "LspInlayHint", { fg = "#554E57", bg = "NONE" })

  vim.api.nvim_set_hl(0, "Pmenu", { bg = "#262626", fg = "#f2f4f8" })
  vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#393939", fg = "#f2f4f8" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#161616" })
  vim.api.nvim_set_hl(0, "FloatBorder", { bg = "#161616", fg = "#393939" })
end

return {
  "nyoom-engineering/oxocarbon.nvim",
  commit = "9f85f6090322f39b11ae04a343d4eb9d12a86897",
  config = function()
    vim.api.nvim_create_autocmd("ColorScheme", {
      callback = function()
        my_touch()
      end,
    })

    vim.opt.background = "dark"
    pcall(vim.cmd.colorscheme, "oxocarbon")
  end,
}
