local function find_project_root()
  -- Prefer Cargo.toml root; fall back to cwd
  local bufname = vim.api.nvim_buf_get_name(0)
  local root = nil
  if vim.fs and vim.fs.dirname then
    local start = (bufname ~= "" and bufname) or vim.uv.cwd()
    root = vim.fs.root(start, { "Cargo.toml", ".git" })
  end
  return root or vim.uv.cwd()
end

local function on_exit(win, buf, code)
  vim.schedule(function()
    if code == 0 then
      -- Success: close the terminal window and wipe the buffer
      if vim.api.nvim_win_is_valid(win) then
        pcall(vim.api.nvim_win_close, win, true)
      end
      if vim.api.nvim_buf_is_loaded(buf) then
        pcall(vim.api.nvim_buf_delete, buf, { force = true })
      end
      vim.notify("cargo install succeeded", vim.log.levels.INFO)
    else
      -- Failure: keep terminal open
      vim.notify("cargo install failed (exit " .. code .. "). Inspect errors above.", vim.log.levels.ERROR)
    end
  end)
end

local function cargo_install_in_term()
  -- Create a fresh scratch buffer & show it in a bottom split
  vim.cmd("botright 12split")
  local win = vim.api.nvim_get_current_win()
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_win_set_buf(win, buf)

  local root = find_project_root()

  -- Start the process in a real terminal; we need an exit code
  local job = vim.fn.jobstart({ "cargo", "install", "--path", "." }, {
    cwd = root,
    term = true,
    on_exit = function(_, code, _)
      on_exit(win, buf, code)
    end,
  })

  if job <= 0 then
    vim.notify("Failed to start terminal/job", vim.log.levels.ERROR)
    return
  end

  -- Drop into insert so you see live output immediately
  vim.cmd("startinsert")
end

-- Map: <leader>cb
vim.keymap.set(
  "n",
  "<leader>cb",
  cargo_install_in_term,
  { desc = "Cargo install in a terminal (auto-close on success)" }
)
