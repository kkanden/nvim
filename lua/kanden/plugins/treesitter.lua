if vim.g.on_nixos then
    require("nvim-treesitter.configs").setup({
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
        },
        sync_install = false,
        auto_install = false,
        indent = {
            enable = true,
        },
    })
end
