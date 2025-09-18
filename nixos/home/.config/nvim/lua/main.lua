require("opts")

vim.cmd.colorscheme("oxocarbon")

local lib = require("lib")

local dir_ft = vim.fs.joinpath(vim.fn.stdpath("config"), "lua/ft")
local dir_plugins = vim.fs.joinpath(vim.fn.stdpath("config"), "lua/plugins")

local function default_on_attach(client, bufnr)
  -- Keymaps
  local map = function(mode, lhs, rhs)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true })
  end

  map("n", "gd", vim.lsp.buf.definition)

  map("n", "K", vim.lsp.buf.hover)
  map("n", "gd", vim.lsp.buf.definition)
  map("n", "gD", vim.lsp.buf.declaration)
  map("n", "gi", vim.lsp.buf.implementation)
  map("n", "gt", vim.lsp.buf.type_definition)
  map("n", "gr", vim.lsp.buf.references)

  map("n", "<leader>rn", vim.lsp.buf.rename)
  map("n", "<leader>ca", vim.lsp.buf.code_action)

  map("n", "<C-k>", vim.lsp.buf.signature_help)

  -- Inlay Hints
  vim.lsp.inlay_hint.enable(true)

  -- Show code lens if supported
  if client.server_capabilities.codeLensProvider then
    vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
      buffer = bufnr,
      callback = vim.lsp.codelens.refresh,
    })

    vim.lsp.codelens.refresh({ bufnr = 0 })
  end
end

local function default_capabilities()
  --- @type lsp.ClientCapabilities
  local caps = vim.lsp.protocol.make_client_capabilities()

  -- Add semantic token support
  caps.textDocument.semanticTokens = {
    formats = { "relative" },
    dynamicRegistration = false,
    requests = {
      range = true,
      full = {
        delta = true,
      },
    },
    tokenTypes = { -- trimmed list for brevity
      "namespace",
      "type",
      "class",
      "enum",
      "interface",
      "function",
      "variable",
      "string",
      "keyword",
    },
    tokenModifiers = {
      "declaration",
      "definition",
      "readonly",
      "deprecated",
      "documentation",
    },
    multilineTokenSupport = true,
    overlappingTokenSupport = true,
  }

  caps.textDocument.codeLens = { dynamicRegistration = true }
  caps.textDocument.rename = { dynamicRegistration = true, prepareSupport = true }
  caps.workspace = {
    configuration = true,
    workspaceFolders = true,
    applyEdit = true,
  }

  -- local cmp_caps = require("cmp_nvim_lsp").default_capabilities(caps)

  return caps
end

vim.lsp.config("*", {
  root_markers = { ".git" },
  capabilities = default_capabilities(),
  on_attach = default_on_attach,
})

for name, type in vim.fs.dir(dir_ft) do
  if type == "file" then
    local stem = lib.strip_ext(name)
    local path = "ft." .. stem

    local M = require(path)

    local fmt_config = M.fmt
    lib.fmt_setup(M.pattern, fmt_config.cmd)

    local lsp_config = M.lsp
    lsp_config.filetypes = M.filetypes

    vim.lsp.config(stem, lsp_config)
    vim.lsp.enable(stem)

    vim.api.nvim_create_autocmd("FileType", {
      pattern = M.filetypes,
      callback = function()
        vim.treesitter.start()
        vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
      end,
    })
  end
end

for name, type in vim.fs.dir(dir_plugins) do
  if type == "file" then
    local stem = lib.strip_ext(name)
    local path = "plugins." .. stem

    local M = require(path)

    M.config()

    for _, binding in ipairs(M.keys) do
      local bind = binding[1]
      local handler = binding[2]
      local desc = binding[3]

      vim.keymap.set("n", bind, handler)
    end
  end
end
