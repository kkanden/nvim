return {
    "j-hui/fidget.nvim",
    opts = {
        notification = {
            window = {
                winblend = 0,
            },
        },
    },
    init = function() vim.notify = require("fidget").notify end,
}
