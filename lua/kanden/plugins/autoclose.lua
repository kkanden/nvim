return {
    "m4xshen/autoclose.nvim",
    event = "InsertEnter",
    opts = {
        options = {
            disabled_filetypes = {
                "text",
                "TelescopePrompt",
                "snacks_picker_input",
            },
            disable_when_touch = true,
        },
        keys = {
            ["'"] = {
                disabled_filetypes = {
                    "markdown",
                    "rmd",
                    "gitcommit",
                    "plaintex",
                },
            },
        },
    },
}
