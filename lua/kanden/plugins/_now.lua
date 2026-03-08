require("mini.icons").setup()
require("mini.icons").mock_nvim_web_devicons()

require("mini.statusline").setup({
    content = {
        active = function()
            local mode, mode_hl = require("mini.statusline").section_mode({
                trunc_width = 0,
            })
            mode = mode:upper()
            local git = require("mini.statusline").section_git({
                trunc_width = 0,
            })
            local filename = require("mini.statusline").section_filename({
                trunc_width = 0,
            })
            local fileinfo = require("mini.statusline").section_fileinfo({
                trunc_width = 1e6,
            })
            local location = require("mini.statusline").section_location({
                trunc_width = 0,
            })

            local lsp = table.concat(
                vim.iter(vim.lsp.get_clients({ bufnr = 0 }))
                    :map(function(x) return x.name end)
                    :totable(),
                ", "
            )
            lsp = lsp ~= "" and lsp .. " | " or lsp

            return require("mini.statusline").combine_groups({
                { hl = mode_hl, strings = { mode } },
                {
                    hl = "MiniStatuslineDevinfo",
                    strings = { git },
                },
                "%<", -- Mark general truncate point
                {
                    hl = "MiniStatuslineFilename",
                    strings = { filename },
                },
                "%=", -- End left alignment
                {
                    hl = "MiniStatuslineFileinfo",
                    strings = { lsp .. fileinfo },
                },
                {
                    hl = mode_hl,
                    strings = { location },
                },
            })
        end,
    },
})
