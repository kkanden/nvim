return {
    {
        "nvim-treesitter/nvim-treesitter",
        enabled = vim.fn.has("win32") == 1, -- install plugin only on windows
        lazy = false,
        opts = {
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
            sync_install = false,
            auto_install = false,
            indent = {
                enable = true,
            },
        },
    },

    {
        "nvim-treesitter/nvim-treesitter-textobjects",
    },
}
