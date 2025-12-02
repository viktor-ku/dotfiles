-- https://github.com/stevearc/conform.nvim/commits/master/
return {
  "stevearc/conform.nvim",
  commit = "4993e07fac6679d0a5005aa7499e0bad2bd39f19",
  config = function()
    local prettier = {
      "biome",
      "prettierd",
      "prettier",
      stop_after_first = true,
    }

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
