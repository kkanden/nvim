if vim.uv.os_uname().version:lower():match("nixos") then
    vim.cmd("packadd nvim-treesitter-legacy")

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
