return {
    "rcarriga/nvim-notify",
    priority = 10e2,
    opts = {
        timeout = 3000,
        max_width = math.floor(vim.o.columns * 0.3),
        render = "wrapped-compact",
        fps = 120,
        top_down = false,
        stages = "static",
        icons = {
            DEBUG = "",
            ERROR = "",
            INFO = "",
            TRACE = "✎",
            WARN = "",
        },
    },
    init = function() vim.notify = require("notify") end,
}
