-- Rose Pine Theme
-- vim.opt.laststatus = 2 -- Or 3 for global statusline
-- vim.opt.statusline = " %F %m %= %l:%c ♥ "
--
-- require("rose-pine").setup({
-- 	variant = "main",
--
-- 	styles = {
-- 		italic = false,
-- 	},
--
-- highlight_groups = {
-- 	StatusLine = { fg = "love", bg = "love", blend = 10 },
-- 	StatusLineNC = {fg = "subtle", bg = "surface" },
-- 	CurSearch = { fg = "base", bg = "leaf", inherit = false },
-- 	Search = { fg = "text", bg = "leaf", blend = 20, inherit = false},
-- 	TelescopeBorder = { bg = "#AE7FA7", fg = "#000000" },
-- 	TelescopeNormal = { bg = "#AE7FA7", fg = "#000000" },
-- 	TelescopeTitle = { fg = "#000000" },
-- 	TelescopeSelection = { fg = "text", bg = "base" },
-- 	TelescopeSelectionCaret = { fg = "rose", bg = "rose" },
-- 	TelescopeMatching = { fg = "#4DB6AC" }
-- },
-- })
--

-- Catppuccin Theme
-- require("catppuccin").setup({
--     no_italic = true,
--     styles = {
--         comments = {},
--         conditionals = {},
--     },
--     integrations = {
--         ts_rainbow = true,
--         harpoon = true,
--     },
--     color_overrides = {
--         mocha = {
--             text = "#F4CDE9",
--             subtext1 = "#DEBAD4",
--             subtext0 = "#C8A6BE",
--             overlay2 = "#B293A8",
--             overlay1 = "#9C7F92",
--             overlay0 = "#866C7D",
--             surface2 = "#705867",
--             surface1 = "#5A4551",
--             surface0 = "#44313B",
--
--             base = "#352939",
--             mantle = "#211924",
--             crust = "#1a1016",
--         },
--     },
--     custom_highlights = function(colors)
--         return {
-- TelescopeBorder = { bg = "#AE7FA7", fg = "#000000" },
-- TelescopeNormal = { bg = "#AE7FA7", fg = "#000000" },
-- TelescopeTitle = { fg = "#000000" },
-- TelescopeSelection = { fg = colors.text, bg = colors.base },
-- TelescopeSelectionCaret = { fg = colors.rose, bg = colors.rose },
-- TelescopeMatching = { fg = "#4DB6AC" },
-- FloatBorder = { bg = "#211924" },
-- FloatTitle = { bg = "#211924" }
--
--         }
--     end,
-- })
require("kanagawa").setup({
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
    ---@module kanagawa
    ---@param colors { theme: kanagawa.ThemeColors, palette: kanagawa.PaletteColors}
    overrides = function(colors)
        local theme = colors.theme
        local palette = colors.palette
        return {
            Normal = { bg = "none" },
            NormalFloat = { bg = palette.sumiInk3 },
            TelescopeNormal = { bg = palette.sumiInk3 },
            WinSeparator = { fg = palette.fujiGray },

            NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

            -- Popular plugins that open floats will link to NormalFloat by default;
            -- set their background accordingly if you wish to keep them dark and borderless
            LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
            MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },

            -- dark cmp menu
            Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },
            PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
            PmenuSbar = { bg = theme.ui.bg_m1 },
            PmenuThumb = { bg = theme.ui.bg_p2 },

            -- Alpha
            AlphaHeader = { fg = palette.lightBlue },
            -- AlphaHeader = { fg = palette.lotusTeal2 },
            AlphaButtons = { fg = palette.lotusYellow4 },
            AlphaShortcut = { fg = palette.oniViolet },
            AlphaFooter = { fg = palette.fujiGray },

            CmpItemKindKeyword = { fg = palette.lightBlue },

            CmpItemKindVariable = { fg = palette.oniViolet },
            CmpItemKindConstant = { fg = palette.lotusViolet4 },
            CmpItemKindReference = { fg = palette.oniViolet },
            CmpItemKindCopilot = { fg = palette.dragonTeal },

            CmpItemKindFunction = { fg = palette.springBlue },
            CmpItemKindMethod = { fg = palette.crystalBlue },
            CmpItemKindConstructor = {},

            CmpItemKindClass = { fg = palette.surimiOrange },
            CmpItemKindInterface = { fg = palette.surimiOrange },
            CmpItemKindStruct = { fg = palette.surimiOrange },
            CmpItemKindEvent = { fg = palette.surimiOrange },
            CmpItemKindEnum = { fg = palette.surimiOrange },
            CmpItemKindUnit = { fg = palette.surimiOrange },

            CmpItemKindModule = { fg = palette.autumnYellow },

            CmpItemKindProperty = { fg = palette.springGreen },
            CmpItemKindField = { fg = palette.springGreen },
            CmpItemKindTypeParameter = { fg = palette.springGreen },
            CmpItemKindEnumMember = { fg = palette.lotusGreen },
            CmpItemKindOperator = { fg = palette.springGreen },
            CmpItemKindSnippet = { fg = palette.fujiGray },
        }
    end,
})

vim.cmd("colorscheme kanagawa")
