local fts = { "markdown", "rmd" }

return {
    {
        "iamcco/markdown-preview.nvim",
        ft = fts,
        cmd = {
            "MarkdownPreviewToggle",
            "MarkdownPreview",
            "MarkdownPreviewStop",
        },
        build = "cd app && yarn install",
        init = function()
            vim.g.mkdp_command_for_global = 1
            vim.g.mkdp_filetypes = fts
            vim.g.mkdp_echo_preview_url = 1
            vim.g.mkdp_browser = "zen"
        end,
    },

    {
        "bullets-vim/bullets.vim",
        ft = fts,
    },
}
