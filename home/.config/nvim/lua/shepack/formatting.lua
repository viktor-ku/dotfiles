return {
  "stevearc/conform.nvim",
  commit = "9fd3d5e0b689ec1bf400c53cbbec72c6fdf24081",
  config = function()
    local prettier = { "prettierd", "prettier", stop_after_first = true }

    require("conform").setup({
      formatters_by_ft = {
        javascript = prettier,
        typescript = prettier,
        javascriptreact = prettier,
        typescriptreact = prettier,
        svelte = prettier,
        vue = prettier,
        css = prettier,
        html = prettier,
        xml = prettier,
        handlebars = prettier,
        json = prettier,
        yaml = prettier,
        markdown = prettier,
        astro = prettier,
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
    })

    vim.keymap.set("n", "<leader>W", function()
      vim.cmd("noautocmd write")
    end, { desc = "Save without formatting" })
  end,
}
