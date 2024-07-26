local prettier = { { "prettierd", "prettier" } }

return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    formatters_by_ft = {
      javascript = prettier,
      typescript = prettier,
      javascriptreact = prettier,
      typescriptreact = prettier,
      svelte = prettier,
      css = prettier,
      html = prettier,
      json = prettier,
      yaml = prettier,
      markdown = prettier,
      lua = { "stylua" },
      python = function(bufnr)
        if require("conform").get_formatter_info("ruff_format", bufnr).available then
          return { "ruff_format" }
        else
          return { "isort", "black" }
        end
      end,
    },
    format_after_save = {
      lsp_fallback = false,
      async = true,
      timeout_ms = 0,
    },
  },
  keys = {
    {
      "<leader>mp",
      function()
        require("conform").format({
          lsp_fallback = true,
          async = false,
          timeout_ms = 500,
        })
      end,
      desc = "Format buffer",
    },
  },
}
