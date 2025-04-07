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

                local configuration =
                    vim.fn["gruvbox_material#get_configuration"]()
                local gruvbox = vim.fn["gruvbox_material#get_palette"](
                    configuration.background,
                    configuration.foreground,
                    configuration.colors_override
                )

                for key, value in pairs(gruvbox) do
                    gruvbox[key] = value[1]:lower() ~= "none" and value[1]
                        or nil
                end

                return vim.tbl_extend("force", kanagawa, gruvbox)
            end,
            css = true,
            tailwind = true,
        },
    },
}
