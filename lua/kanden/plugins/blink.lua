require("blink.cmp").setup({
    keymap = {
        ["<C-b>"] = { "select_and_accept" },
        ["<C-s>"] = { "scroll_documentation_up", "fallback" },
        ["<C-f>"] = { "scroll_documentation_down", "fallback" },
    },
    completion = {
        menu = {
            border = "rounded",
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
            window = {
                border = "rounded",
            },
        },
    },
    signature = {
        enabled = true,
        window = {
            border = "rounded",
        },
    },
    cmdline = {
        enabled = true,
        completion = {
            menu = {
                auto_show = true,
            },
        },
        keymap = {
            ["<C-b>"] = { "select_and_accept" },
        },
    },
    sources = {
        default = {
            "lsp",
            "path",
            "snippets",
            "buffer",
            "lazydev",
            "dadbod",
            "markdown",
        },
        providers = {
            snippets = {
                name = "snippets",
                module = "blink.cmp.sources.snippets",
                score_offset = 1000,
            },
            lazydev = {
                name = "LazyDev",
                module = "lazydev.integrations.blink",
                score_offset = 100,
            },
            dadbod = {
                name = "Dadbod",
                module = "vim_dadbod_completion.blink",
            },
            path = {
                name = "path",
                module = "blink.cmp.sources.path",
                opts = {
                    get_cwd = function(_) return vim.fn.getcwd() end,
                    show_hidden_files_by_default = true,
                },
            },
            markdown = {
                name = "RenderMarkdown",
                module = "render-markdown.integ.blink",
                fallbacks = { "lsp" },
            },
        },
    },
})
