require("blink.cmp").setup({
    keymap = {
        ["<C-b>"] = { "select_and_accept" },
        ["<C-s>"] = { "scroll_documentation_up", "fallback" },
        ["<C-f>"] = { "scroll_documentation_down", "fallback" },
    },
    completion = {
        menu = {
            draw = {
                columns = {
                    { "kind_icon", "label", "label_description", gap = 1 },
                    { "kind", gap = 6 },
                    { "source_name", gap = 1 },
                },
            },
        },
        documentation = {
            auto_show = true,
        },
    },
    signature = {
        enabled = true,
    },
    sources = {
        default = {
            "lsp",
            "path",
            "snippets",
            "buffer",
            "lazydev",
        },
        providers = {
            lazydev = {
                name = "LazyDev",
                module = "lazydev.integrations.blink",
                -- make lazydev completions top priority (see `:h blink.cmp`)
                score_offset = 100,
            },
        },
    },
})
