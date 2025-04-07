return {
    "catgoose/nvim-colorizer.lua",
    event = "BufReadPre",
    opts = {
        filetypes = { "*" },
        user_default_options = {
            names_opts = {
                uppercase = true,
            },
            -- add theme color names
            names_custom = function()
                local kanagawa =
                    require("kanagawa.colors").setup({ theme = "wave" }).palette

                local gruvbox = require("gruvbox").palette

                return vim.tbl_extend("keep", kanagawa, gruvbox)
            end,
            css = true,
            tailwind = true,
        },
    },
}
