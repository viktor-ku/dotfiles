local diffview = require'diffview'

vim.keymap.set('n', '<leader>dv', '<cmd>:DiffviewOpen origin/master...HEAD --imply-local<cr>')

diffview.setup({
  enhanced_diff_hl = true,
  default_args = {
    DiffviewOpen = { "--imply-local" },
  }
})
