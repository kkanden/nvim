local map = require("kanden.lib").map
local augroup = require("kanden.lib").augroup

local fts = { "markdown", "rmd" }
require("render-markdown").setup({
    file_types = fts,
    completions = {
        lsp = {
            enabled = true,
        },
    },
    latex = {
        enabled = true,
    },
})

vim.api.nvim_create_autocmd("FileType", {
    group = augroup("markdown-toggle"),
    pattern = fts,
    callback = function()
        map("n", "<leader>mt", "<Cmd>RenderMarkdown toggle<CR>")
    end,
})
