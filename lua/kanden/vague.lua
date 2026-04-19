require("vague").setup({
    transparent = false,
    bold = false,
    italic = false,
    on_highlights = function(highlights, colors)
        local hl = {
            StatusLineNC = { fg = colors.floatBorder, bg = colors.bg },
        }

        for k, v in pairs(hl) do
            highlights[k] = vim.tbl_extend("force", highlights[k] or {}, v)
        end
    end,
})
