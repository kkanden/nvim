return {
    "catgoose/nvim-colorizer.lua",
    event = "VeryLazy",
    opts = {
        filetypes = { "*" },
        user_default_options = {
            names_opts = {
                uppercase = true,
            },
            css = true,
            tailwind = true,
        },
    },
}
