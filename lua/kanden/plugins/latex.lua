return {
    {
        "lervag/vimtex",
        init = function()
            vim.g.vimtex_imaps_enabled = 0
            if vim.fn.has("win32") then
                vim.g.vimtex_view_general_viewer = "sumatrapdf"
                vim.g.vimtex_view_general_options =
                    "-reuse-instance -forward-search @tex @line @pdf"
            else
                vim.g.vimtex_view_general_viewer = "okular"
                vim.g.vimtex_view_general_options =
                    "--unique file:@pdf#src:@line@tex"
            end
        end,
    },
}
