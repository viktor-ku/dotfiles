local M = {}

M.prettier = { "prettierd", "prettier", stop_after_first = true }

return {
  opts = {
    formatters_by_ft = {
      javascript = M.prettier,
      typescript = M.prettier,
      javascriptreact = M.prettier,
      typescriptreact = M.prettier,
      svelte = M.prettier,
      vue = M.prettier,
      css = M.prettier,
      html = M.prettier,
      xml = M.prettier,
      handlebars = M.prettier,
      json = M.prettier,
      yaml = M.prettier,
      markdown = M.prettier,
      astro = M.prettier,
      lua = { "stylua" },
      rust = { "rustfmt", lsp_format = "fallback" },
      python = function(bufnr)
        if require("conform").get_formatter_info("ruff_format", bufnr).available then
          return { "ruff_format" }
        else
          return { "isort", "black" }
        end
      end,
    },
    format_after_save = {
      async = true,
    },
  },
  config = function(opts)
    require("conform").setup(opts)
  end,
}
