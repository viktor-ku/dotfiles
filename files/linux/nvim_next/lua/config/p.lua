print(vim.api.nvim_get_current_buf())

local function enable_inlay_hint()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end

vim.api.nvim_create_user_command("Whereami", function()
  local Path = require("plenary.path")
  local abspath = vim.fn.expand("%:p")
  local relpath = Path:new(abspath):make_relative(vim.loop.cwd())

  vim.fn.setreg("+", relpath)
  vim.notify('Here: "' .. relpath .. '" (copied)')
end, {})

local bufnr = vim.fn.bufnr(name, false)

local buf_path = vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())
