return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "echasnovski/mini.icons" },
    opts = function()
        local configuration = vim.fn["gruvbox_material#get_configuration"]()
        local palette = vim.fn["gruvbox_material#get_palette"](
            configuration.background,
            configuration.foreground,
            configuration.colors_override
        )
        local theme = require("lualine.themes.gruvbox-material")
        theme.visual.a = { bg = palette.red[1] }
        -- make b component font have the color of the mode, excl. normal mode
        local modes = {
            "insert",
            "visual",
            "replace",
            "command",
            "terminal",
            "inactive",
        }

        for _, mode in ipairs(modes) do
            theme[mode].b.fg = theme[mode].a.bg
        end

        return {
            options = {
                theme = theme,
                section_separators = { left = "", right = "" },
                component_separators = { left = "|", right = "|" },
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "branch", "filename" },
                lualine_c = {},
                lualine_x = {},
                lualine_y = {
                    {
                        "lsp_status",
                        icon = false,
                        symbols = { done = "", separator = ", " },
                    },
                    "filetype",
                },
                lualine_z = { "progress", "location" },
            },
        }
    end,
}
