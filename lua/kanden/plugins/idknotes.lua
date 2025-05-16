return {
    "kkanden/idknotes.nvim",
    dev = false,
    ---@type idknotes.Config
    opts = {
        win_config = {
            width = 0.5,
            height = 0.6,
        },
    },
    config = function(_, opts)
        local idknotes = require("idknotes")

        idknotes.setup(opts)

        vim.keymap.set("n", "<leader>n", "<Cmd>IDKnotes<CR>")

        vim.keymap.set("n", "<leader>m", "<Cmd>IDKnotes!<CR>")
    end,
}
