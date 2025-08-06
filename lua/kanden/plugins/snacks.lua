return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
        zen = {
            toggles = {
                dim = false,
            },
            win = {
                minimal = true,
                width = math.floor(vim.o.columns * 0.7),
                backdrop = { transparent = false },
                keys = { q = "close" },
            },
        },
    },
    keys = {
        {
            "<leader>zz",
            function() require("snacks").zen() end,
            desc = "Open zen mode",
        },
    },
}
