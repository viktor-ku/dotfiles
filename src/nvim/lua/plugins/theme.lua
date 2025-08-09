local M = {}

M.inlayhint_style = function()
  vim.api.nvim_set_hl(0, "LspInlayHint", { fg = "#999999", bg = "NONE" })
end

M.comment_style = function()
  vim.api.nvim_set_hl(0, "Comment", { fg = "#6e6e6e", italic = true })
end

return {
  {
    "nyoom-engineering/oxocarbon.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.opt.background = "dark" -- Oxocarbon supports light/dark
      vim.cmd.colorscheme("oxocarbon")

      -- force truecolor
      vim.o.termguicolors = true

      -- Make inlay hints calm gray across all platforms
      M.inlayhint_style()
      M.comment_style()

      -- Re-apply if colorscheme changes
      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = function()
          M.inlayhint_style()
          M.comment_style()
        end,
      })

      -- after your colorscheme
      vim.api.nvim_set_hl(0, "Pmenu", { bg = "#262626", fg = "#f2f4f8" })
      vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#393939", fg = "#f2f4f8" })
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#161616" })
      vim.api.nvim_set_hl(0, "FloatBorder", { bg = "#161616", fg = "#393939" })

      -- keep it sticky across theme reloads
      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = function()
          vim.api.nvim_set_hl(0, "Pmenu", { bg = "#262626", fg = "#f2f4f8" })
          vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#393939", fg = "#f2f4f8" })
          vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#161616" })
          vim.api.nvim_set_hl(0, "FloatBorder", { bg = "#161616", fg = "#393939" })
        end,
      })
    end,
  },
}
