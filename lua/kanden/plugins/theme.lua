return {
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
}
