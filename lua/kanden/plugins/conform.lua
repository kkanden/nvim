require("conform").setup({
    formatters_by_ft = {
        lua = { "stylua" },
        python = { "isort", "black" },
        r = { "styler" },
    },
})

vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
