return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = function()
    local function find_command()
      if 1 == vim.fn.executable("rg") then
        return { "rg", "--files", "--color", "never", "-g", "!.git" }
      elseif 1 == vim.fn.executable("fd") then
        return { "fd", "--type", "f", "--color", "never", "-E", ".git" }
      elseif 1 == vim.fn.executable("fdfind") then
        return { "fdfind", "--type", "f", "--color", "never", "-E", ".git" }
      elseif 1 == vim.fn.executable("find") and vim.fn.has("win32") == 0 then
        return { "find", ".", "-type", "f" }
      elseif 1 == vim.fn.executable("where") then
        return { "where", "/r", ".", "*" }
      end
    end

    return {
      defaults = {
        prompt_prefix = "🔍 ",
        path_display = function(opts, path)
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
    }
  end,
  keys = {
    {
      "<leader>ff",
      function()
        require("telescope.builtin").find_files({
          cwd = vim.fn.getcwd(),
          hidden = true,
        })
      end,
      desc = "Find files (all)",
    },
    {
      "<leader><leader>",
      function()
        require("telescope.builtin").git_files({
          use_file_path = true,
        })
      end,
      desc = "Find files (git)",
    },
    {
      "<leader>fn",
      function()
        require("telescope.builtin").live_grep({
          cwd = vim.fn.getcwd(),
          disable_coordinates = true,
        })
      end,
      desc = "Fuzzy find (live)",
    },
    {
      "<leader>f/",
      function()
        vim.ui.input({ prompt = "🔍 exact: " }, function(input)
          require("telescope.builtin").grep_string({
            search = input,
            word_match = "-w",
            disable_coordinates = true,
          })
        end)
      end,
      desc = "Fuzzy find (grep, exact)",
    },
    {
      "<leader>/",
      function()
        vim.ui.input({ prompt = "🔍" }, function(input)
          require("telescope.builtin").grep_string({
            search = input,
            disable_coordinates = true,
          })
        end)
      end,
      desc = "Fuzzy find (grep)",
    },
    {
      "<leader>,",
      function()
        require("telescope.builtin").buffers({
          show_all_buffers = true,
          ignore_current_buffer = true,
          only_cwd = true,
          sort_mru = true,
        })
      end,
      desc = "List buffers",
    },
    {
      "<leader>fr",
      function()
        require("telescope.builtin").registers()
      end,
      desc = "List registers",
    },
    {
      "<leader>fg",
      function()
        require("telescope.builtin").git_bcommits({
          use_file_path = true,
        })
      end,
      desc = "List commits for the buffer",
    },
    {
      "<leader>gb",
      function()
        require("telescope.builtin").git_branches({
          use_file_path = true,
          show_remote_tracking_branches = true,
        })
      end,
      desc = "Git branches",
    },
    {
      "<leader>gs",
      function()
        require("telescope.builtin").git_status({
          use_file_path = true,
        })
      end,
      desc = "Git status",
    },
    {
      "<leader>bd",
      function()
        vim.cmd("bd")
      end,
      desc = "Unload the current buffer",
    },
  },
}
