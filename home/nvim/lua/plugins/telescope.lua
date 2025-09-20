local M = {}

---@param name string | nil
function M.attach_mappings(name)
  return function(_, map)
    local actions = require("telescope.actions")

    map({ "i", "n" }, "<C-/>", function(buf)
      actions.which_key(buf)
    end)

    map({ "i", "n" }, "<C-C>", function(buf)
      actions.close(buf)
    end)

    map({ "i", "n" }, "<C-K>", function(buf)
      actions.preview_scrolling_up(buf)
    end)

    map({ "i", "n" }, "<C-J>", function(buf)
      actions.preview_scrolling_down(buf)
    end)

    map({ "i", "n" }, "<C-Q>", function(buf)
      actions.send_to_qflist(buf)
      actions.open_qflist(buf)
    end)

    map({ "i", "n" }, "<CR>", function(buf)
      actions.select_default(buf)
    end)

    map({ "i", "n" }, "<C-P>", function(buf)
      actions.move_selection_previous(buf)
    end)

    map({ "n" }, "k", function(buf)
      actions.move_selection_previous(buf)
    end)

    map({ "i", "n" }, "<C-N>", function(buf)
      actions.move_selection_next(buf)
    end)

    map({ "n" }, "j", function(buf)
      actions.move_selection_next(buf)
    end)

    if name == "buffers" then
      map({ "i", "n" }, "<C-D>", function(buf)
        actions.delete_buffer(buf)
      end)

      map({ "n" }, "d", function(buf)
        actions.delete_buffer(buf)
      end)
    end

    return false
  end
end

return {
  opts = function()
    local find_command = {
      "rg",

      "--files",

      "--color",
      "never",

      "--sort",
      "none",

      "--max-filesize",
      "80M",

      "--max-depth",
      "64",

      "--hidden",

      "--glob",
      "!**.git/*",
    }

    local config = require("telescope.config")

    -- Clone the default Telescope configuration
    local vimgrep_arguments = { unpack(config.values.vimgrep_arguments) }

    -- I want to search in hidden/dot files.
    table.insert(vimgrep_arguments, "--hidden")

    -- I don't want to search in the `.git` directory.
    table.insert(vimgrep_arguments, "--glob")
    table.insert(vimgrep_arguments, "!**/.git/*")

    return {
      defaults = {
        prompt_prefix = "🔍 ",
        vimgrep_arguments = vimgrep_arguments,
        path_display = function(_, path)
          local tail = require("telescope.utils").path_tail(path)
          path = string.format("%s (%s)", tail, path)

          local highlights = {
            {
              {
                #tail, -- highlight start position
                #path, -- highlight end position
              },
              "Comment", -- highlight group name
            },
          }

          return path, highlights
        end,
      },
      pickers = {
        find_files = {
          find_command = find_command,
          hidden = true,
        },
      },
      extensions = {
        fzf = {
          fuzzy = true, -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true, -- override the file sorter
          case_mode = "smart_case", -- or "ignore_case" or "respect_case"
        },
      },
    }
  end,
  config = function(opts)
    local telescope = require("telescope")
    telescope.load_extension("fzf")
    telescope.setup(opts)
  end,
  keys = function()
    vim.keymap.set("n", "<leader>ff", function()
      require("telescope.builtin").find_files({
        cwd = vim.fn.getcwd(),
        hidden = true,
        attach_mappings = M.attach_mappings(),
      })
    end)

    vim.keymap.set("n", "<leader><leader>", function()
      require("telescope.builtin").git_files({
        use_file_path = true,
        attach_mappings = M.attach_mappings(),
      })
    end)

    vim.keymap.set("n", "<leader>fn", function()
      require("telescope.builtin").live_grep({
        cwd = vim.fn.getcwd(),
        disable_coordinates = true,
        attach_mappings = M.attach_mappings(),
      })
    end)

    vim.keymap.set("n", "<leader>f/", function()
      vim.ui.input({ prompt = "🔍 exact: " }, function(input)
        require("telescope.builtin").grep_string({
          search = input,
          word_match = "-w",
          disable_coordinates = true,
          attach_mappings = M.attach_mappings(),
        })
      end)
    end)

    vim.keymap.set("n", "<leader>/", function()
      vim.ui.input({ prompt = "🔍" }, function(input)
        require("telescope.builtin").grep_string({
          search = input,
          disable_coordinates = true,
          attach_mappings = M.attach_mappings(),
        })
      end)
    end)

    vim.keymap.set("n", "<leader>,", function()
      require("telescope.builtin").buffers({
        show_all_buffers = true,
        only_cwd = true,
        sort_mru = true,
        select_current = true,
        attach_mappings = M.attach_mappings("buffers"),
      })
    end)

    vim.keymap.set("n", "<leader>gs", function()
      require("telescope.builtin").git_status({
        use_file_path = true,
        attach_mappings = M.attach_mappings(),
      })
    end)

    vim.keymap.set("n", "<leader>gb", function()
      require("telescope.builtin").git_branches({
        use_file_path = true,
        show_remote_tracking_branches = true,
        attach_mappings = M.attach_mappings(),
      })
    end)

    vim.keymap.set("n", "<leader>fj", function()
      require("telescope.builtin").jumplist({
        attach_mappings = M.attach_mappings(),
      })
    end)

    vim.keymap.set("n", "<leader>fs", function()
      require("telescope.builtin").spell_suggest({
        attach_mappings = M.attach_mappings(),
      })
    end)

    vim.keymap.set("n", "<leader>fg", function()
      require("telescope.builtin").git_bcommits({
        use_file_path = true,
        attach_mappings = M.attach_mappings(),
      })
    end)

    vim.keymap.set("n", "<leader>fr", function()
      require("telescope.builtin").registers({
        attach_mappings = M.attach_mappings(),
      })
    end)

    vim.keymap.set("n", "<leader>ft", function()
      require("telescope.builtin").treesitter({
        symbols = { "var", "function" },
        attach_mappings = M.attach_mappings(),
      })
    end, { buffer = true })

    vim.keymap.set("n", "<leader>fe", function()
      require("telescope.builtin").find_files({
        cwd = vim.fn.getcwd(),
        hidden = true,
        attach_mappings = M.attach_mappings(),
        find_command = {
          "rg",

          "--files",

          "--color",
          "never",

          "--sort",
          "none",

          "--max-filesize",
          "80M",

          "--max-depth",
          "64",

          "--hidden",

          "--glob",
          "**/.env*",
        },
      })
    end)
  end,
}
