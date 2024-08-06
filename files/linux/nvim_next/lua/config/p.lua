List = require("plenary.collections.py_list")

M = {}

M.linter_tools = {
  "eslint_d",
}

M.formatter_tools = {
  "stylua",
  "shfmt",
  "prettierd",
}

print(List(M.linter_tools))
