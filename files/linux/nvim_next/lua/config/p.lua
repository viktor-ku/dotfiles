print(vim.api.nvim_get_current_buf())

local function enable_inlay_hint()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end
