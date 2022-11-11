local material = require('material')
local colors = require 'material.colors'

material.setup {
  lualine_style = 'stealth',

  plugins = { 
    -- check out the docs to see all supported plugins
    "nvim-cmp",
    "telescope",
  },

  async_loading = true,
}

vim.g.material_style = 'darker'

vim.cmd 'colorscheme material'
