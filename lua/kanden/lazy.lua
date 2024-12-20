local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
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
        "nvim-telescope/telescope.nvim",
        version = "0.1.8",
        dependencies = { { "nvim-lua/plenary.nvim" } },
    },

    -- Theme
    -- {
    -- 	"rose-pine/neovim",
    -- 	name = "rose-pine",
    -- },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
    },

    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
    },

    "nvim-treesitter/playground",

    {
        "theprimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" }
    },

    {
        "mbbill/undotree",
        event = "BufEnter"
    },

    "tpope/vim-fugitive",

    -- LSP
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            { "williamboman/mason.nvim", config = true },

            "williamboman/mason-lspconfig.nvim",

            "WhoIsSethDaniel/mason-tool-installer.nvim",

            -- Useful status updates for LSP.
            { "j-hui/fidget.nvim",       opts = {} },

            -- "hrsh7th/cmp-nvim-lsp",
            "saghen/blink.cmp",

            {
                "folke/lazydev.nvim",
                ft = "lua", -- only load on lua files
                opts = {
                    library = {
                        -- See the configuration section for more details
                        -- Load luvit types when the `vim.uv` word is found
                        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                    },
                },
            },
        },
    },

    -- Autocompletion
    -- {
    --     "hrsh7th/nvim-cmp",
    --     event = "InsertEnter",
    --     dependencies = {
    --         {
    --             "L3MON4D3/LuaSnip",
    --             build = (function()
    --                 if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
    --                     return
    --                 end
    --                 return "make install_jsregexp"
    --             end)(),
    --         },
    --         "saadparwaiz1/cmp_luasnip",
    --         "hrsh7th/cmp-nvim-lsp",
    --         "hrsh7th/cmp-path",
    --         "kdheepak/cmp-latex-symbols",
    --     },
    -- },
    --
    {
        'saghen/blink.compat',
        -- use the latest release, via version = '*', if you also use the latest release for blink.cmp
        version = '*',
        -- lazy.nvim will automatically load the plugin when it's required by blink.cmp
        lazy = true,
        -- make sure to set opts so that lazy.nvim calls blink.compat's setup
        opts = {},
    },
    {
        'saghen/blink.cmp',
        -- use a release tag to download pre-built binaries
        version = 'v0.*',
        dependencies = {
            { "R-nvim/cmp-r" }
        },
        -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
        -- build = 'cargo build --release',
        -- If you use nix, you can build from source using latest nightly rust with:
        -- build = 'nix run .#build-plugin',

        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        -- allows extending the providers array elsewhere in your config
        -- without having to redefine it
        opts_extend = { "sources.default" }
    },



    -- Highlight todo, notes, etc in comments
    {
        "folke/todo-comments.nvim",
        event = "VimEnter",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = { signs = false },
    },

    -- R
    {
        "R-nvim/R.nvim",
        event = "BufRead *.R *.r *.Rmd *.rmd"
    },


    -- Surround
    {
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({})
        end,
    },

    -- Indent lines
    {
        "lukas-reineke/indent-blankline.nvim",
        event = "BufEnter",
        main = "ibl",
        ---@module "ibl"
        ---@type ibl.config
        opts = {},
    },

    -- Status Line
    {
        "nvim-lualine/lualine.nvim",
        event = "VimEnter",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        opts = {
            toggler = {
                line = "<leader>c",
                block = "<leader>c",
            },
            opleader = {
                line = "<leader>c",
                block = "<leader>c",
            },
        },
    },

    -- Autoclose
    {
        "m4xshen/autoclose.nvim",
        event = "InsertEnter"
    },

    -- Diagnostics on status line
    {
        "Isrothy/lualine-diagnostic-message",
        event = "BufEnter"
    },

    -- Comment
    {
        "numToStr/Comment.nvim",
        event = "InsertEnter",
        opts = {},
    },

    -- Context
    {
        "SmiteshP/nvim-navic",
        event = "BufEnter",
        dependencies = "neovim/nvim-lspconfig",
        opts = {},
    },

    {
        "norcalli/nvim-colorizer.lua",
        opts = {},
    },

    {
        "nvim-telescope/telescope-file-browser.nvim",
        dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
    },

    -- FZF Telescope
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make'
    },

    -- Smooth scrolling
    {
        "karb94/neoscroll.nvim",
    },

    -- Oil file explorer
    {
        'stevearc/oil.nvim',
        ---@module 'oil'
        ---@type oil.SetupOpts
        opts = {},
        -- Optional dependencies
        dependencies = { { "echasnovski/mini.icons", opts = {} } },
        -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
    },

    {
        'echasnovski/mini.ai',
        version = '*',
        opts = {}
    },
}

require("lazy").setup(plugins, {})
