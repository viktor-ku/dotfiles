local function default_capabilities()
  local caps = vim.lsp.protocol.make_client_capabilities()

  if pcall(require, "cmp_nvim_lsp") then
    return require("cmp_nvim_lsp").default_capabilities(caps)
  end

  return caps
end

vim.lsp.config("*", {
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
