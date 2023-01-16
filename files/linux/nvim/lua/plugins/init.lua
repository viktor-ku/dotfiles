require 'plugins.treesitter'

require('lualine').setup {
  options = {
    theme = 'auto'
  }
}

require 'plugins.theme'

require('plugins.cmp')
require('plugins.lspconfig')

require('Comment').setup {
	basic = true,
}

require('plugins.telescope')
require('plugins.vgit')

require('null-ls').setup()

require 'plugins.hop'

return require('packer').startup({function(use) 
	use 'wbthomason/packer.nvim'
	use 'nvim-treesitter/nvim-treesitter'
	use 'neovim/nvim-lspconfig'

  -- themes
	use 'navarasu/onedark.nvim'
  use 'marko-cerovac/material.nvim'
  use "rebelot/kanagawa.nvim"

	use 'nvim-lua/plenary.nvim'

	use {
		'nvim-lualine/lualine.nvim',
		requires = { 'kyazdani42/nvim-web-devicons', opt = true }
	}

	use 'hrsh7th/nvim-cmp'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-nvim-lua'
	use 'hrsh7th/cmp-nvim-lsp'
	use 'saadparwaiz1/cmp_luasnip'
  use 'onsails/lspkind.nvim'

	use 'L3MON4D3/LuaSnip'
  use "rafamadriz/friendly-snippets"

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

  use {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  }

  use({
    "glepnir/lspsaga.nvim",
    branch = "main",
    config = function()
        require('lspsaga').setup({})
    end,
  })

  use {
    'phaazon/hop.nvim',
    branch = 'v2', -- optional but strongly recommended
  }

  use {
    'saecki/crates.nvim',
    tag = 'v0.3.0',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
        require('crates').setup()
    end,
  }

  use {
    "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end
  }

end, config = {
  package_root = vim.fn.stdpath('config') .. '/site/pack'
}})
