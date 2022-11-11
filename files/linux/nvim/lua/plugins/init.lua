require 'plugins.treesitter'

require('lualine').setup {
  options = {
    theme = 'auto'
  }
}

require 'plugins.theme'

require('plugins.lspconfig')
require('plugins.cmp')

require('Comment').setup {
	basic = true,
}

require('plugins.telescope')

require('vgit').setup()

require('null-ls').setup()

local prettier = require("prettier")
prettier.setup({
  bin = 'prettierd', -- or `'prettierd'` (v0.22+)
  filetypes = {
    "css",
    "graphql",
    "html",
    "javascript",
    "javascriptreact",
    "json",
    "less",
    "markdown",
    "scss",
    "typescript",
    "typescriptreact",
    "yaml",
  },
})

require("flutter-tools").setup{}

return require('packer').startup({function(use) 
	use 'wbthomason/packer.nvim'
	use 'nvim-treesitter/nvim-treesitter'
	use 'neovim/nvim-lspconfig'

  -- themes
	use 'navarasu/onedark.nvim'
  use 'marko-cerovac/material.nvim'

	use 'nvim-lua/plenary.nvim'

	use {
		'nvim-lualine/lualine.nvim',
		requires = { 'kyazdani42/nvim-web-devicons', opt = true }
	}

	use 'hrsh7th/nvim-cmp'
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-path'
	use 'L3MON4D3/LuaSnip'
	use 'saadparwaiz1/cmp_luasnip'

	use 'numToStr/Comment.nvim'

	use { 
		'nvim-telescope/telescope.nvim',
		requires = {
			'nvim-lua/plenary.nvim'
		}
	}
	use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

	use 'p00f/nvim-ts-rainbow'

  use {
    'tanvirtin/vgit.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    }
  }

  use { "nvim-telescope/telescope-file-browser.nvim" }

  use {
    'David-Kunz/cmp-npm',
    requires = {
      'nvim-lua/plenary.nvim'
    }
  }

  use 'jose-elias-alvarez/null-ls.nvim'
  use 'MunifTanjim/prettier.nvim'

  use {'akinsho/flutter-tools.nvim', requires = 'nvim-lua/plenary.nvim'}

end, config = {
  package_root = vim.fn.stdpath('config') .. '/site/pack'
}})
