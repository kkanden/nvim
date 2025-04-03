return {
    "rebelot/kanagawa.nvim",
    priority = 10e4,
    lazy = false,
    init = function() vim.cmd("colorscheme kanagawa") end,
    opts = {
        compile = true,
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
        undercurl = true,
        functionStyle = {},
        statementStyle = { bold = true },
        typeStyle = {},
        transparent = true,
        dimInactive = false,
        terminalColors = true,
        background = { dark = "wave", light = "lotus" },
        theme = "dragon",
    },
}
