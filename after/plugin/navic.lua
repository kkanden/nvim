require("nvim-navic").setup({
    highlight = true
})

local navicHls = { "IconsFile", "IconsModule", "IconsNamespace", "IconsPackage", "IconsClass", "IconsMethod",
    "IconsProperty", "IconsField", "IconsConstructor", "IconsEnum", "IconsInterface", "IconsFunction", "IconsVariable",
    "IconsConstant", "IconsString", "IconsNumber", "IconsBoolean", "IconsArray", "IconsObject", "IconsKey", "IconsNull",
    "IconsEnumMember", "IconsStruct", "IconsEvent", "IconsOperator", "IconsTypeParameter", }
for _, hlName in ipairs(navicHls) do
    hlName = "Navic" .. hlName
    local orgHl = hlName
    local hl
    repeat -- follow linked highlights
        hl = vim.api.nvim_get_hl(0, { name = hlName })
        hlName = hl.link
    until not hl.link
    vim.api.nvim_set_hl(0, orgHl, { fg = "#BF616A", bg = hl.bg })
end
