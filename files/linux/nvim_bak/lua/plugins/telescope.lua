local telescope = require'telescope'

telescope.setup {

}

telescope.load_extension'fzf'
telescope.load_extension'file_browser'

vim.keymap.set('n', '<leader>tf', '<cmd>Telescope find_files<cr>')
vim.keymap.set('n', '<leader>tl', '<cmd>Telescope live_grep<cr>')
vim.keymap.set('n', '<leader>tb', '<cmd>Telescope file_browser<cr>')

