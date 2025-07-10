return {
    cmd = { "rust-analyzer" },
    filetypes = { "rust" },
    root_markers = { "Cargo.toml" },
    settings = {
        ["rust-analyzer"] = {
            inlayHints = {
                bindingModeHints = {
                    enable = false,
                },
                chainingHints = {
                    enable = true,
                },
                closureReturnTypeHints = {
                    enable = "never",
                },
                lifetimeElisionHints = {
                    enable = "never",
                    useParameterNames = false,
                },
                maxLength = 25,
                parameterHints = {
                    enable = true,
                },
                reborrowHints = {
                    enable = "never",
                },
                renderColons = true,
                typeHints = {
                    enable = true,
                    hideClosureInitialization = false,
                    hideNamedConstructor = false,
                },
            },
        },
    },
}
