return {
  "tinted-theming/tinted-nvim",
  commit = "aae5d90cf4821d550130ffc2107de903a07a582f",
  config = function()
    require("tinted-nvim").setup({
      -- Fallback scheme (used when selector cannot resolve a scheme).
      default_scheme = "base16-ayu-dark",

      -- Apply a scheme automatically during startup.
      apply_scheme_on_startup = true,

      -- Compile the scheme for faster startup.
      compile = true,

      capabilities = {
        -- Enable truecolor support (sets `termguicolors`).
        -- If false, cterm colors are used where available.
        truecolor = true,

        -- Some terminal emulators cannot draw undercurls. When disabling
        -- undercurls globally, it falls back to underline.
        undercurl = false,

        -- Set vim.g.terminal_color_0 .. vim.g.terminal_color_17.
        terminal_colors = true,
      },

      ui = {
        -- If true, Normal background is left unset (transparent).
        transparent = false,

        -- Dim background of inactive windows.
        dim_inactive = false,
      },

      -- Change text attributes for certain highlight groups.
      -- Supported attributes: italic, bold, underline, undercurl, strikethrough.
      styles = {
        comments = { italic = true },
        keywords = { bold = true },
        functions = { underline = true },
        variables = { italic = true, underline = true },
        types = { bold = true, underline = true, strikethrough = false },
      },

      -- External scheme selector (resolves scheme names only).
      selector = {
        enabled = true,

        -- "file" | "env" | "cmd"
        mode = "file",

        -- Expects a file that only contains the scheme name.
        path = "~/.local/share/tinted-theming/tinty/current_scheme",

        -- Reads the scheme name from an environment variable.
        env = "TINTED_THEME",

        -- Executes a command that returns the scheme name.
        cmd = "tinty current",

        -- In "file" mode: watch the file, and reload the scheme on changes.
        watch = true,
      },
    })
  end,
}
