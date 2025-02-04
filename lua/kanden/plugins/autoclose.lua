require("autoclose").setup({
    options = {
        disabled_filetypes = {
            "text",
            "TelescopePrompt",
            "snacks_picker_input",
        },
    },
    keys = {
        ["$"] = {
            escape = true,
            close = true,
            pair = "$$",
            enabled_filetypes = {
                "rmd",
                "latex",
                "plaintex",
                "context",
            },
        },
    },
})
