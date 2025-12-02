local function keys()
  vim.keymap.set("n", "<leader>eo", function()
    require("oil").open()
  end)
  vim.keymap.set("n", "<leader>ex", function()
    require("oil").open(vim.fn.getcwd())
  end)
end

-- https://github.com/stevearc/oil.nvim/commits/master
return {
  "stevearc/oil.nvim",
  commit = "cbcb3f997f6f261c577b943ec94e4ef55108dd95",
  config = function()
    require("oil").setup({
      default_file_explorer = true,
      skip_confirm_for_simple_edits = true,
      use_default_keymaps = false,
      view_options = {
        show_hidden = true,
      },
      keymaps = {
        ["?"] = "actions.show_help",
        ["<CR>"] = "actions.select",
        ["<C-r>"] = "actions.refresh",
        ["<C-v>"] = "actions.preview",
        ["<C-p>"] = "actions.parent",
        ["<C-w>"] = "actions.open_cwd",
        ["<C-y>"] = "actions.yank_entry",
        ["<C-d>"] = {
          callback = function()
            require("oil").discard_all_changes()
          end,
        },
      },
    })

    keys()
  end,
}
