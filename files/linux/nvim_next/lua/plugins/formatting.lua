local M = {}

M.prettier = { "prettierd", "prettier", stop_after_first = true }

return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    formatters_by_ft = {
      javascript = M.prettier,
      typescript = M.prettier,
      javascriptreact = M.prettier,
      typescriptreact = M.prettier,
      svelte = M.prettier,
      css = M.prettier,
      html = M.prettier,
      json = M.prettier,
      yaml = M.prettier,
      markdown = M.prettier,
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
      async = true,
    },
  },
  keys = {
    {
      "<leader>mp",
      function()
        require("conform").format({
          async = true,
        })
      end,
      desc = "Format buffer",
    },
  },
}
