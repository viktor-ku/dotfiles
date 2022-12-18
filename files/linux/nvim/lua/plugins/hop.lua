local hop = require('hop')

hop.setup {
  keys = 'etovxqpdygfblzhckisuran'
}

vim.keymap.set('', '<leader>hw', function()
  hop.hint_words({ multi_windows = true })
end, {remap=true})

vim.keymap.set('', '<leader>hp', function()
  hop.hint_patterns({ multi_windows = true })
end, {remap=true})

