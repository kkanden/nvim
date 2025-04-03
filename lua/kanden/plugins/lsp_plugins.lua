return {
    {
        "williamboman/mason.nvim",
        opts = {
            PATH = "append",
        },
    },

    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        opts = {
            ensure_installed = {
                "lua-language-server",
                "r-languageserver",
                "basedpyright",
                "ltex-ls",
                "texlab",
                "rust-analyzer",
                "json-lsp",
                "yaml-language-server",
                "css-lsp",
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
}
