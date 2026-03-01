require("nvim-toggler").setup({
    inverses = {
        ["true"] = "false",
        ["True"] = "False",
        ["TRUE"] = "FALSE",
        ["yes"] = "no",
        ["on"] = "off",
    },
    remove_default_inverses = true,
})
