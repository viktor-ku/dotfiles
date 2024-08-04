-- https://www.lazyvim.org/plugins/lsp#masonnvim-1

local M = {}

M.on_attach = function(client, buf)
  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local opts = { noremap = true, silent = true, buffer = buf }

  -- C-t to go back (check neovim tags tack)
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

return {
  { "williamboman/mason-lspconfig.nvim", config = function() end },

  {

    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    opts_extend = { "ensure_installed" },
    opts = {
      ensure_installed = {
        "stylua",
        "shfmt",
        "prettierd",
        "eslint_d",
      },
    },
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
        for _, name in ipairs(opts.ensure_installed) do
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
    opts = function()
      ---@class PluginLspOpts
      local ret = {
        document_highlight = {
          enabled = true,
        },
        capabilities = {},
        servers = {
          marksman = {},
          astro = {},
          cssls = {},
          tailwindcss = {},
          rust_analyzer = {},
          emmet_ls = {},
          vuels = {},
          eslint = {},
          jsonls = {},
          zls = {},
          vtsls = {},
          lua_ls = {},
        },
        setup = {},
      }

      return ret
    end,
    ---@param opts PluginLspOpts
    config = function(_, opts)
      vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

      local servers = opts.servers

      local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")

      local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        has_cmp and cmp_nvim_lsp.default_capabilities() or {},
        opts.capabilities or {}
      )

      local function setup(server)
        local server_opts = vim.tbl_deep_extend("force", {
          capabilities = vim.deepcopy(capabilities),
          on_attach = M.on_attach,
          handlers = {
            ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
              virtual_text = false,
              signs = false,
            }),
          },
        }, servers[server])

        if server_opts.enabled == false then
          return
        end

        local setup_fn = opts.setup[server]
        local setup_all_fn = opts.setup["*"]

        if setup_fn then
          if setup_fn(server, server_opts) then
            return
          end
        elseif setup_all_fn then
          if setup_all_fn(server, server_opts) then
            return
          end
        end

        require("lspconfig")[server].setup(server_opts)
      end

      local have_mason, mlsp = pcall(require, "mason-lspconfig")
      local all_mslp_servers = {}
      if have_mason then
        all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
      end

      local ensure_installed = {} ---@type string[]
      for server, server_opts in pairs(servers) do
        if server_opts then
          server_opts = server_opts == true and {} or server_opts
          if server_opts.enabled ~= false then
            -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
            if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
              setup(server)
            else
              ensure_installed[#ensure_installed + 1] = server
            end
          end
        end
      end

      if have_mason then
        mlsp.setup({
          ensure_installed = ensure_installed,
          handlers = { setup },
        })
      end
    end,
  },

  {
    "ray-x/lsp_signature.nvim",
    opts = {
      hint_enable = false,
    },
  },
}
