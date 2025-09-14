return {
    "catgoose/nvim-colorizer.lua",
    event = "BufReadPre",
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
