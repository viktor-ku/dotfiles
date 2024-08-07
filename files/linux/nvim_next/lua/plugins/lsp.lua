local M = {}

M.on_attach = function(client, buf)
  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local opts = { noremap = true, silent = true, buffer = buf }

  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
  vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)

  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)

  vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
end

M.lsp_tools = {
  "marksman",
  "astro",
  "cssls",
  "rust_analyzer",
  "emmet_ls",
  "vuels",
  "jsonls",
  "zls",
  "lua_ls",
  "tailwindcss",
  "eslint",
  "vtsls",
}

M.linter_tools = {
  "eslint_d",
}

M.formatter_tools = {
  "stylua",
  "shfmt",
  "prettierd",
}

M.handlers = {
  vtsls = function()
    local lang_settings = {
      updateImportsOnFileMove = { enabled = "always" },
      suggest = {
        completeFunctionCalls = true,
      },
      inlayHints = {
        enumMemberValues = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        parameterNames = { enabled = "literals" },
        parameterTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        variableTypes = { enabled = false },
      },
    }

    return {
      filetypes = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx",
      },
      settings = {
        complete_function_calls = true,
        vtsls = {
          enableMoveToFileCodeAction = true,
          autoUseWorkspaceTsdk = true,
          experimental = {
            completion = {
              enableServerSideFuzzyMatch = true,
            },
          },
        },
        typescript = lang_settings,
        javascript = lang_settings,
      },
    }
  end,
}

M.other_tools = function()
  List = require("plenary.collections.py_list")
  local linter_tools = List(M.linter_tools)
  local formatter_tools = List(M.formatter_tools)
  local tools = linter_tools:concat(formatter_tools)
  return tools
end

return {
  { "williamboman/mason-lspconfig.nvim", config = function() end },

  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function(_, opts)
      require("mason").setup(opts)

      local mr = require("mason-registry")

      mr:on("package:install:success", function()
        vim.defer_fn(function()
          -- trigger FileType event to possibly load this newly installed LSP server
          require("lazy.core.handler.event").trigger({
            event = "FileType",
            buf = vim.api.nvim_get_current_buf(),
          })
        end, 100)
      end)

      mr.refresh(function()
        for _, name in ipairs(M.other_tools()) do
          local p = mr.get_package(name)
          if not p:is_installed() then
            p:install()
          end
        end
      end)
    end,
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      local have_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      local have_mason, mlsp = pcall(require, "mason-lspconfig")

      local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        have_cmp and cmp_nvim_lsp.default_capabilities() or {}
      )

      local server_opts = {
        capabilities = capabilities,
        on_attach = M.on_attach,
      }

      for _, server in ipairs(M.lsp_tools) do
        local handler = M.handlers[server]
        local this_server_opts = handler and handler() or {}
        local opts = vim.tbl_deep_extend("force", server_opts, this_server_opts)
        require("lspconfig")[server].setup(opts)
      end

      if have_mason then
        mlsp.setup({
          ensure_installed = M.lsp_tools,
        })
      end
    end,
  },
}
