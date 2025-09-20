require("opts")
require("shepack")
require("theme")
require("lsp_default")

local lib = require("lib")

for name, ftype in vim.fs.dir("lua/plugins") do
  if ftype == "file" then
    local lua_ext = name:sub(-4)

    if name ~= ".lua" and lua_ext == ".lua" then
      local filename = vim.fs.basename(name)
      local stem = filename:match("(.+)%..+$") or filename

      local ok, M = pcall(require, "plugins/"..stem)

      if not ok then
        print("An error occured while loading "..name)
        print("Error: "..vim.inspect(M))
      else
        local fn_opts = lib.parse_opts(M.opts)
        local fn_config = M.config
        local fn_keys = lib.parse_keys(M.keys)

        local opts = fn_opts()
        fn_config(opts)
        fn_keys(opts)
      end
    end
  end
end

for name, ftype in vim.fs.dir("lsp") do
  if ftype == "file" then
    local lua_ext = name:sub(-4)

    if name ~= ".lua" and lua_ext == ".lua" then
      local filename = vim.fs.basename(name)
      local stem = filename:match("(.+)%..+$") or filename
      pcall(require, "lsp/"..stem)
      vim.lsp.config(stem, require("coq").lsp_ensure_capabilities())
      vim.lsp.enable(stem)
    end
  end
end


vim.api.nvim_create_autocmd({'BufEnter', 'BufWinEnter'}, {
  pattern = "*",
  callback = function()
    pcall(vim.treesitter.start)
  end
})
