-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use ( 'wbthomason/packer.nvim', { run = ':PackerSync' } )

  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.8',
	  -- or                            , branch = '0.1.x',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }

  use ({ 'rose-pine/neovim',
  	name = 'rose-pine'
  })

  use ( 'nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })

  use ( 'nvim-treesitter/playground' )

  use ( 'theprimeagen/harpoon' )

  use ( 'mbbill/undotree' )

  use ( 'tpope/vim-fugitive' )


-- LSP

  use ( 'williamboman/mason.nvim' )

  use ( 'williamboman/mason-lspconfig.nvim' )

  use ( 'neovim/nvim-lspconfig' )
 
  use ( 'hrsh7th/nvim-cmp' )

  use ( 'hrsh7th/cmp-nvim-lsp'  )

-- R

  use ( 'R-nvim/R.nvim' )

  use ({
	  'R-nvim/cmp-r',
	  requires = { {'hrsh7th/nvim-cmp'} },
	  config = function()
		  -- Set up nvim-cmp with cmp-r source
		  require("cmp").setup({
			  sources = {
				  { name = "cmp_r" }
			  }
		  })
		  -- Set up cmp-r itself
		  require("cmp_r").setup({})
		  endconfig = function()
			  -- Set up nvim-cmp with cmp-r source
			  require("cmp").setup({
				  sources = {
					  { name = "cmp_r" }
				  }
			  })
			  -- Set up cmp-r itself
			  require("cmp_r").setup({})
		  end
	  end
  })

end)
