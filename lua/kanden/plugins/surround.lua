require("nvim-surround").setup({
    surrounds = {
        ["f"] = {
            delete = "^(.-[%w_:%.]%()().-(%))()$", -- Modified to include colons and dots
            change = {
                target = "^.-([%w_:%.]+)()%(.-%)()()$", -- Modified to include colons and dots
            },
        },
    },
})
