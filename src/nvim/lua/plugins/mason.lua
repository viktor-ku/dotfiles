local M = {}

M.tools = {
  -- LSP
  "lua-language-server",
  "marksman",
  "css-lsp",
  "rust-analyzer",
  "emmet-language-server",
  "astro-language-server",
  "vue-language-server",
  "json-lsp",
  "zls",
  "tailwindcss-language-server",
  "vtsls",
  "ruff",
  "fish-lsp",
  "systemd-language-server",
}

M.notify_err = function(message)
  vim.notify_once("✗ " .. message, vim.log.levels.ERROR, {
    title = "mason",
  })
end

M.notify_ok = function(message)
  vim.notify_once("✓ " .. message, vim.log.levels.INFO, {
    title = "mason",
  })
end

return {
  {
    "mason-org/mason.nvim",
    lazy = false,
    opts = {
      ui = {
        check_outdated_packages_on_open = true,
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
      pip = {
        upgrade_pip = true,
        install_args = { "--no-cache-dir" },
      },
    },
    config = function(_, opts)
      local mason = require("mason")
      local reg = require("mason-registry")

      -- setup now
      mason.setup(opts)

      reg.refresh(function(refreshed)
        if not refreshed then
          M.notify_err("Failed to refresh mason registries")
        end

        for _, tool in ipairs(M.tools) do
          local ok, pkg = pcall(reg.get_package, tool)

          if ok then
            if not pkg:is_installed() then
              pkg:install(nil, function()
                M.notify_ok(tool .. " installed")
              end)
            end
          else
            M.notify_err(tool .. " not found")
          end
        end
      end)
    end,
  },
}
