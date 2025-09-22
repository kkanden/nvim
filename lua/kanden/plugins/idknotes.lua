return {
    "kkanden/idknotes.nvim",
    event = "VeryLazy",
    ---@type idknotes.Config
    opts = {
        win_config = {
            width = 0.5,
            height = 0.6,
        },
    },
    keys = {
        {
            "<leader>n",
            "<Cmd>IDKnotes<CR>",
        },
        {
            "<leader>m",
            "<Cmd>IDKnotes!<CR>",
        },
    },
}
