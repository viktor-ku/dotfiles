return {
  config = function()
    local opts = {
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
          desc = "Discard all oil changes",
        },
      },
    }

    require("oil").setup(opts)
  end,
  keys = {
    {
      "<leader>eo",
      function()
        require("oil").open()
      end,
      desc = "Open explorer",
    },
    {
      "<leader>ex",
      function()
        require("oil").open(vim.fn.getcwd())
      end,
      desc = "Open explorer",
    },
    {
      "<leader>eq",
      function()
        require("oil").close()
      end,
      desc = "Close explorer",
    },
  },
}
