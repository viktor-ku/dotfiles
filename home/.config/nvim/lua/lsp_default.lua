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
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local opts = {
      buffer = args.buf,
      silent = true,
    }

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
  end,
})
