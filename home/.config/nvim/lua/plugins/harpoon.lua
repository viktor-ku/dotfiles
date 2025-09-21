local M = {}

---@param buf_path string
function M.buf_cursor_pos(buf_path)
  local bufnr = vim.fn.bufnr(buf_path, false)

  local pos = { 1, 0 }
  if bufnr ~= -1 then
    pos = vim.api.nvim_win_get_cursor(0)
  end

  return pos
end

---@return string
function M.buf_rel_path()
  local Path = require("plenary.path")
  local buf_path = vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())
  local relpath = Path:new(buf_path):make_relative(vim.uv.cwd())
  return relpath
end

---@param buf_path string
function M.harpoon_ctx(buf_path)
  local pos = M.buf_cursor_pos(buf_path)
  return {
    row = pos[1],
    col = pos[2],
  }
end

function M.harpoon_item()
  local buf_path = M.buf_rel_path()
  return { value = buf_path, context = M.harpoon_ctx(buf_path) }
end

return {
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
  keys = function()
    vim.keymap.set("n", "<C-h>", function()
      require("harpoon"):list():select(1)
    end)
    vim.keymap.set("n", "<C-t>", function()
      require("harpoon"):list():select(2)
    end)

    vim.keymap.set("n", "<C-p>", function()
      require("harpoon"):list():prev()
    end)

    vim.keymap.set("n", "<C-n>", function()
      require("harpoon"):list():next()
    end)

    vim.keymap.set("n", "<leader>he", function()
      local harpoon = require("harpoon")
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end)

    vim.keymap.set("n", "<leader>h1", function()
      require("harpoon"):list():replace_at(1, M.harpoon_item())
    end)
    vim.keymap.set("n", "<leader>h2", function()
      require("harpoon"):list():replace_at(2, M.harpoon_item())
    end)
    vim.keymap.set("n", "<leader>h3", function()
      require("harpoon"):list():replace_at(3, M.harpoon_item())
    end)
    vim.keymap.set("n", "<leader>h4", function()
      require("harpoon"):list():replace_at(4, M.harpoon_item())
    end)

    vim.keymap.set("n", "<leader>ha", function()
      require("harpoon"):list():add()
    end)

    vim.keymap.set("n", "<leader>hc", function()
      require("harpoon"):list():clear()
    end)
  end,
}
