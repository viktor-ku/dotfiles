--- @param config_fn fun(): vim.lsp.Config
local function setup(config_fn)
  local config = config_fn()

  return config
end

return setup
