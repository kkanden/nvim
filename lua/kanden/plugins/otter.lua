local loaded_langs = {}

return {
    "jmbuhr/otter.nvim",
    ft = { "markdown", "rmd", "quarto" },
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
    },
    opts = {},
    config = function()
        local augroup = require("kanden.lib").augroup

        vim.api.nvim_create_autocmd("InsertEnter", {
            group = augroup("otter-autostart"),
            pattern = { "*.md", "*.qmd" },
            callback = function()
                -- Get the treesitter parser for the current buffer
                local ok, parser = pcall(vim.treesitter.get_parser)
                if not ok then return end

                local otter = require("otter")
                local extensions = require("otter.tools.extensions")
                local attached = {}

                -- Get the language for the current cursor position (this will be
                -- determined by the current code chunk if that's where the cursor
                -- is)
                local line, col = vim.fn.line(".") - 1, vim.fn.col(".")
                local lang = parser
                    :language_for_range({ line, col, line, col + 1 })
                    :lang()

                -- If otter has an extension available for that language, and if
                -- the LSP isn't already attached, then activate otter for that
                -- language
                if
                    extensions[lang] and not vim.tbl_contains(attached, lang)
                then
                    table.insert(attached, lang)
                    if not vim.tbl_contains(loaded_langs, lang) then
                        table.insert(loaded_langs, lang)
                        vim.notify(("Activating otter... [%s]"):format(lang))
                    end
                    vim.schedule(
                        function() otter.activate({ lang }, true, true) end
                    )
                end
            end,
        })
    end,
}
