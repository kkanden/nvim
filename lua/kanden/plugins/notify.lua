vim.notify = require("notify")

require("notify").setup({
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
})
