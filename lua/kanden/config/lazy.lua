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
        priority = 1002,
        lazy = false,
        config = req("theme"),
    },

    -- Oil file explorer
    {
        "stevearc/oil.nvim",
        priority = 1001,
        ---@module 'oil'
        ---@type oil.SetupOpts
        -- Optional dependencies
        dependencies = { { "echasnovski/mini.icons", opts = {} } },
        -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
        config = req("oil"),
    },

    {
        "rcarriga/nvim-notify",
        priority = 1001,
        config = req("notify"),
    },

    -- snacks
    {
        "folke/snacks.nvim",
        priority = 1000,
        config = req("snacks"),
    },

    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        event = { "BufReadPost", "BufNewFile" },
        build = ":TSUpdate",
        config = req("treesitter"),
    },

    {
        "nvim-treesitter/nvim-treesitter-textobjects",
    },

    -- LSP
    {
        "williamboman/mason.nvim",
        opts = {
            PATH = "append",
        },
    },

    {

        "WhoIsSethDaniel/mason-tool-installer.nvim",
        config = req("mason"),
    },

    -- Useful status updates for LSP.
    {
        "j-hui/fidget.nvim",
        opts = {
            notification = {
                window = {
                    winblend = 0,
                },
            },
        },
    },

    {
        "saghen/blink.cmp",
        version = "*",
        dependencies = {
            -- community sources
            "Kaiser-Yang/blink-cmp-git",
            "disrupted/blink-cmp-conventional-commits",
            "mikavilpas/blink-ripgrep.nvim",
            {
                "L3MON4D3/LuaSnip",
                lazy = true,
                version = "v2.*",
                config = req("luasnip"),
                build = "make install_jsregexp",
                dependencies = { "rafamadriz/friendly-snippets" },
            },
        },
    },

    {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
            library = {
                -- See the configuration section for more details
                -- Load luvit types when the `vim.uv` word is found
                {
                    path = "${3rd}/luv/library",
                    words = { "vim%.uv" },
                },
            },
        },
    },

    -- Formatting tools
    {
        "stevearc/conform.nvim",
        event = { "BufReadPost", "BufNewFile" },
        config = req("conform"),
    },

    -- Autocompletion
    {
        "saghen/blink.cmp",
        lazy = false,
        -- use a release tag to download pre-built binaries
        version = "v0.*",
        opts_extend = { "sources.default" },
        config = req("blink"),
    },

    -- Rust
    {
        "saecki/crates.nvim",
        event = { "BufRead Cargo.toml" },
        tag = "stable",
        config = req("crates"),
    },

    -- R
    {
        "R-nvim/R.nvim",
        ft = { "r", "rmd" },
        config = req("rnvim"),
    },

    -- Status Line
    {
        "echasnovski/mini.statusline",
        version = "*",
        config = req("ministatusline"),
    },

    -- Harpoon
    {
        "theprimeagen/harpoon",
        lazy = false,
        branch = "harpoon2",
        commit = "e76cb03", -- latest doesn't really work for me, this is good enough
        dependencies = { "nvim-lua/plenary.nvim" },
        config = req("harpoon"),
    },

    -- Undotree
    {
        "mbbill/undotree",
        config = req("undotree"),
    },

    -- FuGITive
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
        event = "VeryLazy",
        version = "*",
        opts = {},
        config = req("surround"),
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

    -- Colors color names
    {
        "catgoose/nvim-colorizer.lua",
        event = "BufReadPre",
        config = req("colorizer"),
    },
    -- Smooth scrolling
    {
        "declancm/cinnamon.nvim",
        version = "*", -- use latest release
        config = req("cinnamon"),
    },

    -- Extra a,i motions
    {
        "echasnovski/mini.ai",
        version = "*",
        config = req("miniai"),
    },

    -- Move selected text
    {
        "echasnovski/mini.move",
        version = "*",
        config = req("minimove"),
    },

    -- Search count
    {
        "kevinhwang91/nvim-hlslens",
        config = req("hlslens"),
    },

    -- better input visuals
    {
        "stevearc/dressing.nvim",
        opts = {},
    },

    -- Git info in sidebar
    {
        "lewis6991/gitsigns.nvim",
        event = "BufReadPost",
        opts = {},
    },

    -- Git merge tool
    {
        "sindrets/diffview.nvim",
        cmd = "DiffviewOpen",
        opts = {},
    },

    -- SQL
    {

        "kristijanhusak/vim-dadbod-ui",
        dependencies = {
            { "tpope/vim-dadbod", lazy = true },
            {
                "kristijanhusak/vim-dadbod-completion",
                ft = { "sql", "mysql", "plsql" },
                lazy = true,
            },
        },
        cmd = {
            "DBUI",
            "DBUIToggle",
            "DBUIAddConnection",
            "DBUIFindBuffer",
        },
    },

    {
        "folke/flash.nvim",
        event = "VeryLazy",
        ---@type Flash.Config
        opts = {
            jump = {
                autojump = true,
            },
        },
        -- stylua: ignore
        keys = {
            { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
            { "r", mode = "o", function() require("flash").remote() end, desc = "remote flash" },
        },
    },

    -- tmux
    {
        "christoomey/vim-tmux-navigator",
        enabled = vim.fn.has("win32") == 0,
        cmd = {
            "TmuxNavigateLeft",
            "TmuxNavigateDown",
            "TmuxNavigateUp",
            "TmuxNavigateRight",
            "TmuxNavigatePrevious",
            "TmuxNavigatorProcessList",
        },
        keys = {
            { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
            { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
            { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
            { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
            { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
        },
    },

    -- jupytext
    {
        "goerz/jupytext.nvim",
        version = "0.2.0",
        opts = {}, -- see Options
    },

    {
        "jmbuhr/otter.nvim",
        ft = { "markdown", "rmd", "quarto" },
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        opts = {},
        config = req("otter"),
    },

    -- Markdown
    {
        "MeanderingProgrammer/render-markdown.nvim",
        ft = { "markdown", "rmd" },
        dependencies = {
            -- "nvim-treesitter/nvim-treesitter",
            "echasnovski/mini.icons",
        },
        config = req("render-markdown"),
    },

    {
        "iamcco/markdown-preview.nvim",
        ft = { "rmd", "markdown" },
        cmd = {
            "MarkdownPreviewToggle",
            "MarkdownPreview",
            "MarkdownPreviewStop",
        },
        build = "cd app && npm install",
        config = function() vim.g.mkdp_filetypes = { "markdown" } end,
    },

    -- Keep cursor centered
    {
        "arnamak/stay-centered.nvim",
        config = req("stay-centered"),
    },
}

require("lazy").setup(plugins, {})
