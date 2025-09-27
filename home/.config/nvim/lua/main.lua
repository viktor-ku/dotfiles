require("opts")
require("shepack")
require("theme")
require("lsp_default")

local lib = require("lib")
local config_dir = vim.fn.stdpath("config")

for name, ftype in vim.fs.dir(vim.fs.joinpath(config_dir, "lua", "plugins")) do
  if ftype == "file" then
    local lua_ext = name:sub(-4)

    if name ~= ".lua" and lua_ext == ".lua" then
      local filename = vim.fs.basename(name)
      local stem = filename:match("(.+)%..+$") or filename

      local M = require("plugins/" .. stem)

      local fn_opts = lib.parse_opts(M.opts, function()
        return nil
      end)
      local fn_config = lib.parse_config(M.config)
      local fn_keys = lib.parse_keys(M.keys)

      local opts = fn_opts()
      fn_config(opts)
      fn_keys(opts)
    end
  end
end

for name, ftype in vim.fs.dir(vim.fs.joinpath(config_dir, "lsp")) do
  if ftype == "file" then
    local lua_ext = name:sub(-4)

    if name ~= ".lua" and lua_ext == ".lua" then
      local filename = vim.fs.basename(name)
      local stem = filename:match("(.+)%..+$") or filename
      pcall(require, "lsp/" .. stem)
      vim.lsp.enable(stem)
    end
  end
end

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  pattern = "*",
  callback = function()
    pcall(vim.treesitter.start)
  end,
})
