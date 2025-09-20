return {
  config = function ()
    vim.g.coq_settings = {
      auto_start = 'shut-up',
      ["display.preview.border"] = {
        {"", "NormalFloat"},
        {"", "NormalFloat"},
        {"", "NormalFloat"},
        {" ", "NormalFloat"},
        {"", "NormalFloat"},
        {"", "NormalFloat"},
        {"", "NormalFloat"},
        {" ", "NormalFloat"},
      },
      ["display.pum"] = {
        y_max_len = 60,
        x_max_len = 90,
        x_truncate_len = 90,
      },
      ["display.pum.kind_context"] = {"", ""},
      ["display.pum.source_context"] = {"", ""},
    }
  end
}
