--- @param config_fn fun(): vim.lsp.Config
local function setup(config_fn)
  return config_fn()
end

return setup
