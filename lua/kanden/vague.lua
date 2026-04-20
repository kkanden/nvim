require("vague").setup({
    transparent = false,
    bold = false,
    italic = false,
    on_highlights = function(highlights, colors)
        local hl = {
            StatusLineNC = { fg = colors.floatBorder, bg = colors.bg },
            PmenuSel = { fg = colors.constant, bg = colors.line },
            PmenuBorder = { fg = colors.floatBorder },
        }
        highlights.Pmenu.bg = nil

        for k, v in pairs(hl) do
            highlights[k] = vim.tbl_extend("force", highlights[k] or {}, v)
        end
    end,
})
