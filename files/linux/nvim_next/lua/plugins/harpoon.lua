return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")
    local extensions = require("harpoon.extensions")

    harpoon:setup({
      default = {
        VimLeavePre = function()
          harpoon:list():clear()
        end,
      },
    })

    harpoon:extend(extensions.builtins.navigate_with_number())
  end,
  keys = {
    {
      "<leader>ha",
      function()
        local harpoon = require("harpoon")
        harpoon:list():add()
      end,
      desc = "Harpoon add",
    },
    {
      "<leader>he",
      function()
        local harpoon = require("harpoon")
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end,
      desc = "Harpoon toggle ui",
    },
    {
      "<C-n>",
      function()
        local harpoon = require("harpoon")
        harpoon:list():next()
      end,
      desc = "Harpoon next",
    },
    {
      "<C-p>",
      function()
        local harpoon = require("harpoon")
        harpoon:list():prev()
      end,
      desc = "Harpoon prev",
    },
    {
      "<C-h>",
      function()
        local harpoon = require("harpoon")
        harpoon:list():select(1)
      end,
      desc = "Harpoon 1",
    },
    {
      "<C-t>",
      function()
        local harpoon = require("harpoon")
        harpoon:list():select(2)
      end,
      desc = "Harpoon 2",
    },
    {
      "<C-S-J>",
      function()
        local harpoon = require("harpoon")
        harpoon:list():select(3)
      end,
      desc = "Harpoon 3",
    },
    {
      "<C-S-K>",
      function()
        local harpoon = require("harpoon")
        harpoon:list():select(4)
      end,
      desc = "Harpoon 4",
    },
  },
}
