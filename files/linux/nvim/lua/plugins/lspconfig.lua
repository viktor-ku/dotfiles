-- C-o (:help jumplist)

local lspconfig = require'lspconfig'

local on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local opts = { noremap=true, silent=true, buffer=bufnr }

	-- C-t to go back (check neovim tags tack)
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
	vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
	vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
	vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, opts)
	vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)

	vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
	vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
	vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
	vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)
	-- try Telescope diagnostics
  vim.keymap.set('n', '<leader>td', "<cmd>Telescope diagnostics<cr>", opts)
	-- C-q to put all of errors to quick fix list

	vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
	vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
	vim.keymap.set('n', '<leader>wl', function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, opts)

	vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
	vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)

	vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
	vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, opts)

end

local lsp_flags = {
	debounce_text_changes = 150,
}

local capabilities = require('cmp_nvim_lsp').default_capabilities()

require("mason").setup()
require('mason-lspconfig').setup({
  ensure_installed = {
    "tsserver",
    "marksman",
    "astro",
    "cssls",
    "pyright",
    "tailwindcss",
    "rust_analyzer",
    "emmet_ls",
    "vuels",
    "eslint"
  }
})

lspconfig.marksman.setup {
	capabilities = capabilities,
	on_attach = on_attach,
	flags = lsp_flags,
}

lspconfig.astro.setup {
	capabilities = capabilities,
	on_attach = on_attach,
	flags = lsp_flags,
}

lspconfig.cssls.setup {
	capabilities = capabilities,
	on_attach = on_attach,
	flags = lsp_flags,
}

lspconfig.pyright.setup {
	capabilities = capabilities,
	on_attach = on_attach,
	flags = lsp_flags,
}

lspconfig.tsserver.setup {
	capabilities = capabilities,
	on_attach = on_attach,
	flags = lsp_flags,
}

lspconfig.vuels.setup {
	capabilities = capabilities,
	on_attach = on_attach,
	flags = lsp_flags,
}

lspconfig.tailwindcss.setup {
	capabilities = capabilities,
	on_attach = on_attach,
	flags = lsp_flags,
}

lspconfig.eslint.setup {
	capabilities = capabilities,
	on_attach = on_attach,
	flags = lsp_flags,
}

lspconfig.rust_analyzer.setup {
	capabilities = capabilities,
	on_attach = on_attach,
	flags = lsp_flags,
	settings = {
		["rust-analyzer"] = {}
	}
}

lspconfig.emmet_ls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { 'html', 'typescriptreact', 'javascriptreact', 'css', 'sass', 'scss', 'less' },
  init_options = {
    html = {
      options = {
        -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
        ["bem.enabled"] = true,
      },
    },
  }
}
