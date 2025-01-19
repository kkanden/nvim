local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--branch=stable",
        lazyrepo,
        lazypath,
    })
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

local req = function(module)
    local reqfun = function() require("kanden.plugins." .. module) end
    return reqfun
end

local plugins = {

    -- Theme
    {
        "rebelot/kanagawa.nvim",
        priority = 1000,
        lazy = false,
        config = req("theme"),
    },

    -- Oil file explorer
    {
        "stevearc/oil.nvim",
        ---@module 'oil'
        ---@type oil.SetupOpts
        -- Optional dependencies
        dependencies = { { "echasnovski/mini.icons", opts = {} } },
        -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
        config = req("oil"),
    },

    -- Telescope
    {
        "nvim-telescope/telescope.nvim",
        lazy = false,
        version = "0.1.8",
        dependencies = { { "nvim-lua/plenary.nvim" } },
        config = req("telescope"),
    },

    {
        "nvim-telescope/telescope-fzf-native.nvim",
        lazy = false,
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "nvim-lua/plenary.nvim",
        },
        build = "make",
        config = req("fzf_telescope"),
    },

    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        event = { "BufReadPost", "BufNewFile" },
        build = ":TSUpdate",
        config = req("treesitter"),
    },

    -- LSP
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            { "williamboman/mason.nvim", config = true },

            "williamboman/mason-lspconfig.nvim",

            "WhoIsSethDaniel/mason-tool-installer.nvim",

            -- Useful status updates for LSP.
            { "j-hui/fidget.nvim", opts = {} },

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
        config = req("lsp"),
    },

    {
        "nvimtools/none-ls.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = { "nvim-lua/plenary.nvim" },
        config = req("nullls"),
    },

    -- Autocompletion
    {
        "saghen/blink.compat",
        -- use the latest release, via version = '*', if you also use the latest release for blink.cmp
        version = "*",
        -- lazy.nvim will automatically load the plugin when it's required by blink.cmp
        lazy = true,
        -- make sure to set opts so that lazy.nvim calls blink.compat's setup
        opts = {},
    },

    {
        "saghen/blink.cmp",
        lazy = false,
        -- use a release tag to download pre-built binaries
        version = "v0.*",
        dependencies = {
            { "R-nvim/cmp-r" },
        },
        opts_extend = { "sources.default" },
        config = req("blink"),
    },

    -- Status Line
    {
        "echasnovski/mini.statusline",
        version = "*",
        config = req("ministatusline"),
    },

    -- R
    {
        "R-nvim/R.nvim",
        ft = { "r", "rmd" },
        config = req("rnvim"),
    },

    {
        "theprimeagen/harpoon",
        lazy = false,
        branch = "harpoon2",
        commit = "e76cb03",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = req("harpoon"),
    },

    {
        "mbbill/undotree",
        config = req("undotree"),
    },

    {
        "tpope/vim-fugitive",
        config = req("fugitive"),
    },

    -- Highlight todo, notes, etc in comments
    {
        "folke/todo-comments.nvim",
        events = "InsertEnter",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = { signs = false },
    },

    -- Surround
    {
        "kylechui/nvim-surround",
        event = "InsertEnter",
        version = "*",
        opts = {},
    },

    -- Indent lines
    {
        "lukas-reineke/indent-blankline.nvim",
        event = "BufReadPost",
        main = "ibl",
        config = req("indent"),
    },

    -- Autoclose
    {
        "m4xshen/autoclose.nvim",
        event = "InsertEnter",
        config = req("autoclose"),
    },

    -- Comment
    {
        "numToStr/Comment.nvim",
        event = "BufEnter",
        opts = {},
    },

    {
        "norcalli/nvim-colorizer.lua",
        config = req("colorizer"),
    },

    -- Smooth scrolling
    {
        "karb94/neoscroll.nvim",
        event = "BufReadPost",
        config = req("neoscroll"),
    },

    {
        "echasnovski/mini.ai",
        version = "*",
        opts = {},
    },

    {
        "kevinhwang91/nvim-hlslens",
        config = req("hlslens"),
    },

    -- better input visuals
    {
        "stevearc/dressing.nvim",
        opts = {},
    },

    {
        "lewis6991/gitsigns.nvim",
        event = "BufReadPost",
        opts = {},
    },

    {
        "sindrets/diffview.nvim",
        cmd = "DiffviewOpen",
        opts = {},
    },
}

require("lazy").setup(plugins, {})
