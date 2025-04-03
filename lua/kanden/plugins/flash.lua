return {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {
        jump = {
            autojump = true,
        },
    },
    keys = {
        {
            "s",
            mode = { "n", "x", "o" },
            function() require("flash").jump() end,
            desc = "flash",
        },
        {
            "r",
            mode = "o",
            function() require("flash").remote() end,
            desc = "remote flash",
        },
    },
}
