local map = require("kanden.lib").map
local augroup = require("kanden.lib").augroup

local fts = { "markdown", "rmd" }

return {
    {
        "MeanderingProgrammer/render-markdown.nvim",
        ft = fts,
        dependencies = {
            -- "nvim-treesitter/nvim-treesitter",
            "echasnovski/mini.icons",
        },
        opts = {

            enabled = false, -- don't autostart
            render_modes = true, -- render in all modes, inc. insert, reduces dizziness
            file_types = fts,
            completions = {
                lsp = {
                    enabled = true,
                },
            },
            latex = {
                enabled = true,
            },
        },
        config = function()
            vim.api.nvim_create_autocmd("FileType", {
                group = augroup("markdown-toggle"),
                pattern = fts,
                callback = function()
                    map(
                        "n",
                        "<leader>mt",
                        "<Cmd>RenderMarkdown toggle<CR>",
                        { buffer = 0 }
                    )
                end,
            })
        end,
    },

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
        end,
    },
}
