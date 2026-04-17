require("idknotes").setup(
    ---@type idknotes.Config
    {
        win_config = {
            width = 0.5,
            height = 0.6,
        },
    }
)

vim.keymap.set("n", "<leader>n", "<Cmd>IDKnotes<CR>")
vim.keymap.set("n", "<leader>m", "<Cmd>IDKnotes!<CR>")
