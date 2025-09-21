local M = {}

function M.my_touch()
  vim.api.nvim_set_hl(0, "Comment", { fg = "#9A89A1", italic = true })
  vim.api.nvim_set_hl(0, "LspInlayHint", { fg = "#554E57", bg = "NONE" })

  -- vim.api.nvim_set_hl(0, "Pmenu", { bg = "#262626", fg = "#f2f4f8" })
  -- vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#393939", fg = "#f2f4f8" })
  -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#161616" })
  -- vim.api.nvim_set_hl(0, "FloatBorder", { bg = "#161616", fg = "#393939" })
end

vim.opt.background = "dark"
vim.cmd.colorscheme("oxocarbon")

M.my_touch()

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    M.my_touch()
  end,
})
