local M = {}

---@param buf_path string
M.buf_cursor_pos = function(buf_path)
  local bufnr = vim.fn.bufnr(buf_path, false)

  local pos = { 1, 0 }
  if bufnr ~= -1 then
    pos = vim.api.nvim_win_get_cursor(0)
  end

  return pos
end

---@return string
M.buf_rel_path = function()
  local Path = require("plenary.path")
  local buf_path = vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())
  local relpath = Path:new(buf_path):make_relative(vim.uv.cwd())
  return relpath
end

---@param buf_path string
M.harpoon_ctx = function(buf_path)
  local pos = M.buf_cursor_pos(buf_path)
  return {
    row = pos[1],
    col = pos[2],
  }
end

M.harpoon_item = function()
  local buf_path = M.buf_rel_path()
  return { value = buf_path, context = M.harpoon_ctx(buf_path) }
end

return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")

    harpoon:setup({
      default = {
        VimLeavePre = function()
          harpoon:list():clear()
        end,
      },
    })
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
      "<leader>h1",
      function()
        local harpoon = require("harpoon")
        harpoon:list():replace_at(1, M.harpoon_item())
      end,
      desc = "Harpoon add",
    },
    {
      "<leader>h2",
      function()
        local harpoon = require("harpoon")
        harpoon:list():replace_at(2, M.harpoon_item())
      end,
      desc = "Harpoon add",
    },
    {
      "<leader>h3",
      function()
        local harpoon = require("harpoon")
        harpoon:list():replace_at(3, M.harpoon_item())
      end,
      desc = "Harpoon add",
    },
    {
      "<leader>h4",
      function()
        local harpoon = require("harpoon")
        harpoon:list():replace_at(4, M.harpoon_item())
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
