require 'plugins.treesitter'

require('lualine').setup {
  options = {
    theme = 'auto'
  }
}

require 'plugins.theme'

require('null-ls').setup()
require('plugins.cmp')
require('plugins.neoconf')
require('venom').setup()
require('plugins.lspconfig')

require('Comment').setup {
	basic = true,
}

require('plugins.telescope')
require('plugins.vgit')

require 'plugins.hop'
require 'plugins.diffview'

local Path = require "plenary.path"

vim.api.nvim_create_user_command("Whereami", function()
    local abspath = vim.fn.expand("%:p")
    local relpath = Path:new(abspath):make_relative(vim.loop.cwd())
    
    vim.fn.setreg("+", relpath)
    vim.notify('Here: "' .. relpath .. '" (copied)')
end, {})

local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup({function(use) 

	use 'wbthomason/packer.nvim'
	use 'nvim-treesitter/nvim-treesitter'
  use 'folke/neoconf.nvim'
  use {
    'rafi/neoconf-venom.nvim',
    requires = { 'nvim-lua/plenary.nvim' }
  }
	use 'neovim/nvim-lspconfig'

  -- themes
	use 'navarasu/onedark.nvim'
  use 'marko-cerovac/material.nvim'
  -- use "rebelot/kanagawa.nvim"

	use 'nvim-lua/plenary.nvim'

  use "sindrets/diffview.nvim" 

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

  use {
    'LukasPietzschmann/telescope-tabs',
    requires = { 'nvim-telescope/telescope.nvim' },
    config = function()
      require'telescope-tabs'.setup {
        -- Your custom config :^)
      }
    end
  }

  use "b0o/schemastore.nvim"

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end

end, config = {
  package_root = vim.fn.stdpath('config') .. '/site/pack'
}})
