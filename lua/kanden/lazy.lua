local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local plugins = {

	{
		'nvim-telescope/telescope.nvim', version = '0.1.8',
		-- or                            , branch = '0.1.x',
		dependencies = { {'nvim-lua/plenary.nvim'} }
	},

	{ 
		'rose-pine/neovim',
		name = 'rose-pine'
	},

	{
		'nvim-treesitter/nvim-treesitter',
		build = ':TSUpdate',
	},

	'nvim-treesitter/playground',

	'theprimeagen/harpoon',

	'mbbill/undotree',

	'tpope/vim-fugitive',


	-- LSP

	'williamboman/mason.nvim',

	'williamboman/mason-lspconfig.nvim',

	'neovim/nvim-lspconfig',

	'hrsh7th/nvim-cmp',

	'hrsh7th/cmp-nvim-lsp',

    -- setup for lua ls
    {
        'folke/neodev.nvim',
        opts = {}
    },

	-- R

	'R-nvim/R.nvim',

	{
		'R-nvim/cmp-r',
		dependencies = { {'hrsh7th/nvim-cmp'} },
	},
}

require("lazy").setup(plugins, {})
