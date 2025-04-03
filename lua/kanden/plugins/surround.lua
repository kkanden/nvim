return {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    version = "*",
    opts = {
        surrounds = {
            ["f"] = {
                delete = "^(.-[%w_:%.]%()().-(%))()$", -- Modified to include colons and dots
                change = {
                    target = "^.-([%w_:%.]+)()%(.-%)()()$", -- Modified to include colons and dots
                },
            },
        },
    },
}
