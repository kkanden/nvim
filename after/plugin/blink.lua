require("blink.cmp").setup({
    keymap = {
        ["<C-b>"] = { "select_and_accept" },
        ['<C-s>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
    },
    completion = {
        menu = {
            draw = {
                columns = {
                    { "kind_icon",   "label", "label_description", gap = 1 },
                    { "kind",        gap = 6 },
                    { "source_name", gap = 1 }
                }
            }
        },
        documentation = {
            auto_show = true
        }
    },
    sources = {
        default = {
            'lsp', 'path', 'snippets', 'buffer', 'cmp_r'
        },
        providers = {
            cmp_r = {
                name = "cmp_r",
                module = 'blink.compat.source',
            }
        }
        -- cmdline = {},
    },
})
