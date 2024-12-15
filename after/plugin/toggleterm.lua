require('toggleterm').setup({
    size = 10,
    direction = "float",
    open_mapping = [[c\]],
    shell = "pwsh.exe",
    highlights = {
        NormalFloat = {
            guibg = "#1e1e1e",
            guifg = "#ffffff"
        },
        FloatBorder = {
            guibg = "#1e1e1e",
            guifg = "#ffffff"
        },
    },
    float_opts = {
        border = "curved",
        title_pos = "center",
        width = math.ceil(vim.o.columns * 0.6),
        height = math.ceil(vim.o.columns * 0.15),
    }
})
