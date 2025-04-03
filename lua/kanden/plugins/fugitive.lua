return {
    "tpope/vim-fugitive",
    keys = {
        { "<leader>gs", vim.cmd.Git },
        { "<leader>gp", ":Git pull<CR>" },
        { "<leader>gd", ":Git diff<CR>" },
    },
    cmd = { "Git" },
}
