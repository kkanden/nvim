return {
    "kkanden/idknotes.nvim",
    dev = true,
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
