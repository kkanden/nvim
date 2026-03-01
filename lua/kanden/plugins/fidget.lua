require("fidget").setup({
    notification = {
        window = {
            winblend = 0,
        },
    },
})

vim.notify = require("fidget").notify
