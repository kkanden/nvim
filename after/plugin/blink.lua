require("blink.cmp").setup({
    keymap = {
        ["<C-b>"] = { "select_and_accept" },
        ['<C-s>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
    },
    sources = {
        completion = {
            enabled_providers = { 'lsp', 'path', 'snippets', 'buffer', 'cmp_r' }
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
