require("blink-cmp").setup({
    keymap = {
        ["<C-b>"] = { "select_and_accept" },
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
        trigger = {
            show_on_keyword = true,
            show_on_insert = true,
        },
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
    snippets = {
        preset = "luasnip",
    },
    sources = {
        default = {
            "lsp",
            "path",
            "snippets",
            "buffer",
            "lazydev",
            "ripgrep",
        },
        providers = {
            lsp = {
                name = "LSP",
                module = "blink.cmp.sources.lsp",
                score_offset = 10e3 - 1,
            },
            buffer = {
                module = "blink.cmp.sources.buffer",
                score_offset = -10e3,
            },
            snippets = {
                name = "snippets",
                module = "blink.cmp.sources.snippets",
                score_offset = 10e3,
                -- should_show_items = trigger(";"),
                -- transform_items = transform_trigger(";"),
            },
            lazydev = {
                name = "LazyDev",
                module = "lazydev.integrations.blink",
                score_offset = 10e3,
            },
            path = {
                name = "path",
                module = "blink.cmp.sources.path",
                score_offset = 10e3 + 1,
                opts = {
                    get_cwd = function(_) return vim.fn.getcwd() end,
                    show_hidden_files_by_default = true,
                },
            },
            ripgrep = {
                name = "rg",
                module = "blink-ripgrep",
                fallbacks = { "buffer" },
                score_offset = -10e4,
                transform_items = function(_, items)
                    for _, item in ipairs(items) do
                        item.kind_name = nil
                    end
                    return items
                end,
            },
        },
    },
})
