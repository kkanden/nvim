local augroup = require("kanden.lib").augroup
local map = require("kanden.lib").map
return {
    {
        "lervag/vimtex",
        init = function()
            vim.g.vimtex_imaps_enabled = 0
            vim.g.vimtex_view_method = "sioyek"
            vim.g.vimtex_callback_progpath = "wsl nvim"
            vim.g.vimtex_view_sioyek_options = "--nofocus"

            vim.api.nvim_create_autocmd("FileType", {
                pattern = "tex",
                group = augroup("vimtex-mappings"),
                callback = function()
                    -- change math and item text objects mappings
                    map({ "x", "o" }, "im", "<plug>(vimtex-i$)", { buffer = 0 })
                    map({ "x", "o" }, "am", "<plug>(vimtex-a$)", { buffer = 0 })

                    map({ "x", "o" }, "ii", "<plug>(vimtex-im)", { buffer = 0 })
                    map({ "x", "o" }, "ai", "<plug>(vimtex-am)", { buffer = 0 })

                    map(
                        { "n" },
                        "tsm",
                        "<plug>(vimtex-env-toggle-math)",
                        { buffer = 0 }
                    )
                end,
            })
        end,
    },
}
