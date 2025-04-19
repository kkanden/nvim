return {
    {
        "lervag/vimtex",
        init = function()
            vim.g.vimtex_imaps_enabled = 0
            vim.g.vimtex_view_general_viewer = "sumatrapdf"
            vim.g.vimtex_view_general_options =
                "-reuse-instance -forward-search @tex @line @pdf"
        end,
    },
}
