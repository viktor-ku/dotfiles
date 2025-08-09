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
    vim.lsp.codelens.refresh()
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

  local cmp_caps = require("cmp_nvim_lsp").default_capabilities(caps)

  return cmp_caps
end

vim.lsp.config("*", {
  root_markers = { ".git" },
  capabilities = default_capabilities(),
  on_attach = default_on_attach,
})

local path = vim.fn.stdpath("config") .. "/lua/lsp"
local files = vim.fn.readdir(path)

for _, file in ipairs(files) do
  local ext = file:sub(-4)

  if ext == ".lua" then
    local stem = file:sub(1, -5)
    local config = require("lsp." .. stem)
    if type(config) == "table" and config.cmd ~= nil then
      vim.lsp.config(stem, config)
      vim.lsp.enable(stem)
    end
  end
end
