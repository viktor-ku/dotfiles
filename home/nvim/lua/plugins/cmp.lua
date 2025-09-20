return {
  config = function()
    local cmp = require("cmp")

    local max_width = 50

    cmp.setup({
      snippet = nil,

      mapping = cmp.mapping.preset.insert({
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
      }),

      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "path" },
        { name = "buffer" },
      }),

      window = {
        --- @class cmp.CompletionWindowOptions: cmp.WindowOptions
        completion = {
          border = nil,
          max_width = max_width + 5,
          winblend = 0,
        },
        --- @class cmp.DocumentationWindowOptions: cmp.WindowOptions
        documentation = {
          border = nil,
          max_width = max_width + 5,
          winblend = 0,
        },
      },

      formatting = {
        format = function(entry, vim_item)
          if vim_item.abbr and #vim_item.abbr > max_width then
            vim_item.abbr = string.sub(vim_item.abbr, 1, max_width) .. "…"
          end

          if vim_item.menu and #vim_item.menu > max_width then
            vim_item.menu = string.sub(vim_item.menu, 1, max_width) .. "…"
          end

          return vim_item
        end,
      },
    })
  end,
}
