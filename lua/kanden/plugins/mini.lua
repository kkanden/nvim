return {
    "nvim-mini/mini.nvim",
    init = function()
        -- mini.ai
        local gen_spec = require("mini.ai").gen_spec
        require("mini.ai").setup({
            custom_textobjects = {
                -- Tweak function call to detect : (eg. `data.table::setDT()` in R)
                f = gen_spec.function_call({
                    name_pattern = "[%w_%.:]",
                }),

                -- Function definition (needs treesitter queries with these captures)
                F = gen_spec.treesitter({
                    a = "@function.outer",
                    i = "@function.inner",
                }),
                c = gen_spec.treesitter({
                    a = "@conditional.outer",
                    i = "@conditional.inner",
                }),
            },
        })

        -- mini.icons
        require("mini.icons").setup()
        require("mini.icons").mock_nvim_web_devicons()

        -- mini.move
        require("mini.move").setup({
            mappings = {
                left = "H",
                right = "L",
                down = "J",
                up = "K",
            },
        })

        -- mini.pick
        require("mini.pick").setup({
            options = {
                use_cache = true,
            },
            mappings = {
                delete_left = "",
                scroll_down = "<C-d>",
                scroll_up = "<C-u>",
                choose_2 = {
                    char = "<C-b>",
                    func = function()
                        local cur_item =
                            require("mini.pick").get_picker_matches().current
                        local choose =
                            require("mini.pick").get_picker_opts().source.choose
                        choose(cur_item)
                        return true
                    end,
                },
            },
        })
        vim.ui.select = require("mini.pick").ui_select

        -- mini.statusline
        require("mini.statusline").setup({
            content = {
                active = function()
                    local mode, mode_hl =
                        require("mini.statusline").section_mode({
                            trunc_width = 0,
                        })
                    mode = mode:upper()
                    local git = require("mini.statusline").section_git({
                        trunc_width = 0,
                    })
                    local filename =
                        require("mini.statusline").section_filename({
                            trunc_width = 0,
                        })
                    local fileinfo =
                        require("mini.statusline").section_fileinfo({
                            trunc_width = 1e6,
                        })
                    local location =
                        require("mini.statusline").section_location({
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
    end,
    keys = {
        {

            "ff",
            function() require("mini.pick").builtin.files() end,
            desc = "mini.pick: files",
        },
        {
            "<leader>pn",
            function()
                require("mini.pick").builtin.files(
                    nil,
                    { source = { cwd = vim.fn.stdpath("config") } }
                )
            end,
            desc = "mini,pick: nvim config files",
        },
        {
            "<leader>ps",
            function() require("mini.pick").builtin.grep_live() end,
            desc = "mini.pick: grep",
        },
        {
            "<leader>pb",
            function() require("mini.pick").builtin.buffers() end,
            desc = "mini.pick: buffers",
        },
        {
            "<leader>ph",
            function() require("mini.pick").builtin.help() end,
            desc = "mini.pick: help",
        },
        {
            "<leader>pk",
            function() require("mini.extra").pickers.keymaps() end,
            desc = "mini.pick: keymaps",
        },
    },
}
