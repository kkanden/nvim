require("vague").setup({
    transparent = false,
    bold = false,
    italic = false,
    on_highlights = function(highlights, colors)
        local hl = {
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
            MiniStatuslineFilename = { fg = colors.floatBorder },
        }

        for k, v in pairs(hl) do
            highlights[k] = vim.tbl_extend("force", highlights[k] or {}, v)
        end
    end,
})
