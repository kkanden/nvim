return {
    "tpope/vim-fugitive",
    event = "VeryLazy",
    keys = {
        { "<leader>gs", vim.cmd.Git },
        { "<leader>gp", ":Git pull<CR>" },
        { "<leader>gd", ":Git diff<CR>" },
    },
    cmd = { "Git" },
}
