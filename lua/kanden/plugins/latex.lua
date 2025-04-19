return {
    {
        "lervag/vimtex",
        init = function()
            vim.g.vimtex_imaps_enabled = 0
            -- vim.g.vimtex_view_general_viewer = "sh ~/.local/bin/sumatrapdf"
            -- vim.g.vimtex_view_general_options =
            --     "-reuse-instance -forward-search @tex @line @pdf"

            vim.g.vimtex_view_general_viewer = "okular"
            vim.g.vimtex_view_general_options =
                "--unique file:@pdf#src:@line@tex"
        end,
    },
}
