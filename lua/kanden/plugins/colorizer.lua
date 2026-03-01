require("colorizer").setup({
    filetypes = { "*" },
    lazy_load = true,
    options = {
        parsers = {
            names = {
                uppercase = true,
            },
            css = true,
            tailwind = { enable = true },
        },
    },
})
