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
            "dadbod",
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
                    get_cwd = function(context)
                        return vim.fn.getcwd():format(context.bufnr)
                    end,
                    show_hidden_files_by_default = true,
                },
            },
        },
    },
})
