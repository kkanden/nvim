return {
    {
        "rebelot/kanagawa.nvim",
        priority = 10e4,
        lazy = false,
        opts = {
            compile = true,
            background = {
                dark = "wave",
            },
            colors = {
                theme = {
                    all = {
                        ui = {
                            bg_gutter = "none",
                        },
                    },
                },
            },
            commentStyle = { italic = false },
            keywordStyle = { italic = false },
            undercurl = true,
            functionStyle = {},
            statementStyle = { bold = true },
            typeStyle = {},
            transparent = true,
            dimInactive = false,
            terminalColors = true,
            ---@type fun(colors: KanagawaColorsSpec): table<string, table>
            overrides = function(colors)
                local theme = colors.theme
                local palette = colors.palette
                return {
                    -- restore background color for other windows
                    NormalFloat = { bg = palette.sumiInk3 },
                    FloatBorder = { bg = palette.sumiInk3 },
                    FloatTitle = { bg = palette.sumiInk3 },
                    TelescopeNormal = { bg = palette.sumiInk3 },

                    -- split separator color
                    WinSeparator = { fg = palette.fujiGray },

                    NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

                    -- Popular plugins that open floats will link to NormalFloat by default;
                    -- set their background accordingly if you wish to keep them dark and borderless
                    LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
                    MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },

                    -- dark cmp menu
                    Pmenu = { fg = theme.ui.shade0, bg = "none" },
                    PmenuSel = { fg = "none", bg = theme.ui.bg_p2 },
                    PmenuSbar = { bg = theme.ui.bg_m1 },
                    PmenuThumb = { bg = theme.ui.bg_p2 },

                    -- Alpha
                    AlphaHeader = { fg = palette.lightBlue },
                    -- AlphaHeader = { fg = palette.lotusTeal2 },
                    AlphaButtons = { fg = palette.lotusYellow4 },
                    AlphaShortcut = { fg = palette.oniViolet },
                    AlphaFooter = { fg = palette.fujiGray },

                    -- Cmp
                    BlinkCmpMenu = { bg = "none" },
                    BlinkCmpMenuBorder = { bg = "none" },

                    BlinkCmpItemKindKeyword = { fg = palette.lightBlue },
                    BlinkCmpItemKindVariable = { fg = palette.oniViolet },
                    BlinkCmpItemKindConstant = { fg = palette.lotusViolet4 },
                    BlinkCmpItemKindReference = { fg = palette.oniViolet },
                    BlinkCmpItemKindCopilot = { fg = palette.dragonTeal },
                    BlinkCmpItemKindFunction = { fg = palette.springBlue },
                    BlinkCmpItemKindMethod = { fg = palette.crystalBlue },
                    BlinkCmpItemKindConstructor = {},
                    BlinkCmpItemKindClass = { fg = palette.surimiOrange },
                    BlinkCmpItemKindInterface = { fg = palette.surimiOrange },
                    BlinkCmpItemKindStruct = { fg = palette.surimiOrange },
                    BlinkCmpItemKindEvent = { fg = palette.surimiOrange },
                    BlinkCmpItemKindEnum = { fg = palette.surimiOrange },
                    BlinkCmpItemKindUnit = { fg = palette.surimiOrange },
                    BlinkCmpItemKindModule = { fg = palette.autumnYellow },
                    BlinkCmpItemKindProperty = { fg = palette.springGreen },
                    BlinkCmpItemKindField = { fg = palette.springGreen },
                    BlinkCmpItemKindTypeParameter = { fg = palette.springGreen },
                    BlinkCmpItemKindEnumMember = { fg = palette.lotusGreen },
                    BlinkCmpItemKindOperator = { fg = palette.springGreen },
                    BlinkCmpItemKindSnippet = { fg = palette.fujiGray },
                }
            end,
        },
    },
    {
        "sainnhe/gruvbox-material",
        priority = 10e4,
        lazy = false,
        config = function()
            local g = vim.g

            vim.o.background = "dark"
            g.gruvbox_material_background = "soft"
            g.gruvbox_material_foreground = "mix"
            g.gruvbox_material_disable_italic_comment = 1
            g.gruvbox_material_enable_bold = 1
            g.gruvbox_material_float_style = "dim"

            g.gruvbox_material_diagnostic_virtual_text = "colored"

            local configuration = vim.fn["gruvbox_material#get_configuration"]()
            local palette = vim.fn["gruvbox_material#get_palette"](
                configuration.background,
                configuration.foreground,
                configuration.colors_override
            )

            for key, value in pairs(palette) do
                palette[key] = value[1]
            end
            local override = function()
                local overrides = {
                    WinSeparator = { fg = palette.fg1 },

                    Pmenu = { bg = palette.bg2 },
                    PmenuSel = { fg = "NONE", bg = palette.bg4 },

                    BlinkCmpItemKindKeyword = { fg = palette.blue },
                    BlinkCmpItemKindVariable = { fg = palette.purple },
                    BlinkCmpItemKindConstant = { fg = palette.purple },
                    BlinkCmpItemKindReference = { fg = palette.purple },
                    BlinkCmpItemKindCopilot = {
                        fg = palette.bg_visual_green,
                    },
                    BlinkCmpItemKindFunction = { fg = palette.blue },
                    BlinkCmpItemKindMethod = { fg = palette.blue },
                    BlinkCmpItemKindConstructor = {},
                    BlinkCmpItemKindClass = { fg = palette.orange },
                    BlinkCmpItemKindInterface = { fg = palette.orange },
                    BlinkCmpItemKindStruct = { fg = palette.orange },
                    BlinkCmpItemKindEvent = { fg = palette.orange },
                    BlinkCmpItemKindEnum = { fg = palette.orange },
                    BlinkCmpItemKindUnit = { fg = palette.orange },
                    BlinkCmpItemKindModule = { fg = palette.yellow },
                    BlinkCmpItemKindProperty = { fg = palette.aqua },
                    BlinkCmpItemKindField = { fg = palette.aqua },
                    BlinkCmpItemKindTypeParameter = { fg = palette.aqua },
                    BlinkCmpItemKindEnumMember = { fg = palette.green },
                    BlinkCmpItemKindOperator = { fg = palette.aqua },
                    BlinkCmpItemKindSnippet = { fg = palette.grey2 },
                }

                for hl, spec in pairs(overrides) do
                    local current = vim.api.nvim_get_hl(0, { name = hl })
                    spec = vim.tbl_extend("keep", spec, current)
                    vim.api.nvim_set_hl(0, hl, spec)
                end
            end

            vim.api.nvim_create_autocmd("ColorScheme", {
                pattern = "gruvbox-material",
                callback = override,
            })
        end,
    },
}
