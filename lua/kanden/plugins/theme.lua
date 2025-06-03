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
            g.gruvbox_material_transparent_background = 1
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

                    Pmenu = { fg = palette.fg1, bg = "none" },
                    PmenuSel = { fg = "none", bg = palette.bg4 },

                    GitSignsChange = { fg = palette.yellow, link = "" },

                    BlinkCmpMenu = { bg = "none" },
                    BlinkCmpMenuBorder = { bg = "none" },
                    BlinkCmpKindClass = { fg = palette.orange },
                    BlinkCmpKindConstant = { fg = palette.purple },
                    BlinkCmpKindConstructor = {},
                    BlinkCmpKindCopilot = { fg = palette.bg_visual_green },
                    BlinkCmpKindEnum = { fg = palette.orange },
                    BlinkCmpKindEnumMember = { fg = palette.green },
                    BlinkCmpKindEvent = { fg = palette.orange },
                    BlinkCmpKindField = { fg = palette.aqua },
                    BlinkCmpKindFunction = { fg = palette.blue },
                    BlinkCmpKindInterface = { fg = palette.orange },
                    BlinkCmpKindKeyword = { fg = palette.red },
                    BlinkCmpKindMethod = { fg = palette.blue },
                    BlinkCmpKindModule = { fg = palette.yellow },
                    BlinkCmpKindOperator = { fg = palette.aqua },
                    BlinkCmpKindProperty = { fg = palette.aqua },
                    BlinkCmpKindReference = { fg = palette.purple },
                    BlinkCmpKindSnippet = { fg = palette.blue },
                    BlinkCmpKindStruct = { fg = palette.orange },
                    BlinkCmpKindTypeParameter = { fg = palette.aqua },
                    BlinkCmpKindUnit = { fg = palette.orange },
                    BlinkCmpKindVariable = { fg = palette.purple },
                }

                for hl, spec in pairs(overrides) do
                    local current = vim.api.nvim_get_hl(0, { name = hl })
                    spec = vim.tbl_extend("keep", spec, current)

                    -- idk if this is necessary but it fixed some issues
                    spec.link = spec.link and nil
                    spec.default = spec.default and nil

                    vim.api.nvim_set_hl(0, hl, spec)
                end
            end

            vim.api.nvim_create_autocmd("ColorScheme", {
                pattern = "gruvbox-material",
                callback = override,
            })
        end,
    },
    -- Lazy
    {
        "vague2k/vague.nvim",
        lazy = false,
        opts = {
            transparent = false,
            bold = false,
            italic = false,
            on_highlights = function(_, colors)
                local highlights = {
                    BlinkCmpKindClass = { fg = colors.number },
                    BlinkCmpKindConstant = { fg = colors.parameter },
                    BlinkCmpKindConstructor = {},
                    BlinkCmpKindEnum = { fg = colors.number },
                    BlinkCmpKindEnumMember = { fg = colors.plus },
                    BlinkCmpKindEvent = { fg = colors.number },
                    BlinkCmpKindField = { fg = colors.keyword },
                    BlinkCmpKindFunction = { fg = colors.hint },
                    BlinkCmpKindInterface = { fg = colors.number },
                    BlinkCmpKindKeyword = { fg = colors.error },
                    BlinkCmpKindMethod = { fg = colors.hint },
                    BlinkCmpKindModule = { fg = colors.warning },
                    BlinkCmpKindOperator = { fg = colors.keyword },
                    BlinkCmpKindProperty = { fg = colors.keyword },
                    BlinkCmpKindReference = { fg = colors.parameter },
                    BlinkCmpKindSnippet = { fg = colors.keyword },
                    BlinkCmpKindStruct = { fg = colors.number },
                    BlinkCmpKindTypeParameter = { fg = colors.hint },
                    BlinkCmpKindUnit = { fg = colors.number },
                    BlinkCmpKindVariable = { fg = colors.parameter },
                }
                for name, setting in pairs(highlights) do
                    vim.api.nvim_command(
                        string.format(
                            "highlight %s guifg=%s guibg=%s guisp=%s gui=%s",
                            name,
                            setting.fg or "none",
                            setting.bg or "none",
                            setting.sp or "none",
                            setting.gui or "none"
                        )
                    )
                end
            end,
        },
    },
}
