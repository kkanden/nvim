return {
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    tag = "stable",
    opts = {
        lsp = {
            enabled = true,
            actions = true,
            completion = true,
            hover = true,
        },
    },
}
