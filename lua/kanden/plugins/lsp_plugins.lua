return {
    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            library = {
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
        event = "VeryLazy",
        opts = {
            notification = {
                window = {
                    winblend = 0,
                },
            },
        },
    },
}
