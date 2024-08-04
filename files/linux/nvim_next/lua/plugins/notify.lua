return {
  "rcarriga/nvim-notify",
  opts = {
    timeout = 4000,
    render = "wrapped-compact",
    stages = "static",
    max_width = 50,
  },
  init = function()
    vim.notify = require("notify")
  end,
}
