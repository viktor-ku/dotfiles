return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  priority = 900,
  lazy = false,
  init = function(plugin)
    -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
    -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
    -- no longer trigger the **nvim-treesitter** module to be loaded in time.
    -- Luckily, the only things that those plugins need are the custom queries, which we make available
    -- during startup.
    require("lazy.core.loader").add_to_rtp(plugin)
    require("nvim-treesitter.query_predicates")
  end,
  config = function()
    local opts = {
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = {
        enable = true,
      },
      sync_install = false,
      ensure_installed = {
        "astro",
        "bash",
        "cmake",
        "comment",
        "cpp",
        "c",
        "css",
        "csv",
        "diff",
        "dockerfile",
        "editorconfig",
        "git_config",
        "git_rebase",
        "gitattributes",
        "gitcommit",
        "gitignore",
        "glsl",
        "go",
        "gpg",
        "graphql",
        "html",
        "htmldjango",
        "http",
        "java",
        "javascript",
        "jq",
        "jsdoc",
        "json",
        "json5",
        "kotlin",
        "liquid",
        "lua",
        "luadoc",
        "luap",
        "make",
        "markdown",
        "markdown_inline",
        "nginx",
        "objc",
        "objdump",
        "passwd",
        "pem",
        "php",
        "phpdoc",
        "printf",
        "proto",
        "python",
        "query",
        "regex",
        "requirements",
        "robots",
        "ruby",
        "rust",
        "scala",
        "scss",
        "sql",
        "ssh_config",
        "styled",
        "svelte",
        "terraform",
        "textproto",
        "tmux",
        "toml",
        "typescript",
        "vue",
        "xml",
        "yaml",
        "zig",
      },
    }

    local configs = require("nvim-treesitter.configs")

    configs.setup(opts)
  end,
}
