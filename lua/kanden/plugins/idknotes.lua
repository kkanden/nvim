local map = require("kanden.lib").map

require("idknotes").setup(
    ---@type idknotes.Config
    {
        win_config = {
            width = 0.5,
            height = 0.6,
        },
    }
)

map("n", "<leader>n", "<Cmd>IDKnotes<CR>")
map("n", "<leader>m", "<Cmd>IDKnotes!<CR>")
