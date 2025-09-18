local M = {}

function M.fmt_setup(pattern, cmd)
  vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = pattern,
    callback = function(args)
      local bufnr = args.buf
      local orig = table.concat(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false), "\n")

      local res = vim.system(cmd, { stdin = orig, text = true }):wait()

      if res.code ~= 0 then
        vim.notify(("formatting failed (%d): %s"):format(res.code, res.stderr or ""), vim.log.levels.WARN)
        return
      end

      local out = res.stdout or ""

      if vim.trim(orig) == vim.trim(out) then
        return
      end

      local view = vim.fn.winsaveview()
      local lines = vim.split(out, "\n", { plain = true, trimempty = true })
      vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
      vim.fn.winrestview(view)
    end,
  })
end

function M.strip_ext(filename)
  return filename:match("^(.*)%.[^%.]+$") or filename
end

return M
