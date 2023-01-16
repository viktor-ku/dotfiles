local ts = require 'nvim-treesitter.configs'

ts.setup {
	ensure_installed = { 
    "rust", 

    "typescript", "tsx", "javascript", "astro", 
    "vue", "svelte", "css", "graphql", 
    "html", "go", "json", "toml",
    "yaml", "sql",

    "c", "cpp",
    "lua", 
    "bash",
    "diff",
    "dockerfile",
    "git_rebase",
    "gitignore",
    "glsl",
    "help",
    "make",
    "markdown",
    "python",
  },

	auto_install = true,

	highlight = {
		enable = true,
	},

  autotag = {
    enable = true,
  },

  indent = {
    enable = true,
    disable = {},
  },

  highlight = {
    enable = true,
    disable = {},
  },

  rainbow = {
    enable = false,
    extended_mode = true,
    max_file_lines = nil,
    colors = {
      '#E57373',
      '#FFF176',
      '#9575CD',
      '#64B5F6',
      '#4DD0E1',
      '#81C784',
      '#DCE775',
      '#FFB74D',
    },
    disable = {"jsx", "html"}
  },
}

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }

