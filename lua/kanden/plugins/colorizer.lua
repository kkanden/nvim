require("colorizer").setup({
    filetypes = { "*" },
    user_default_options = {
        names_opts = {
            uppercase = true,
        },
        -- add theme color names
        names_custom = function()
            local colors = require("kanagawa.colors").setup()
            return colors.palette
        end,
        css = true,
        tailwind = true,
    },
})
