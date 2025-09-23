return {
    {
        "echasnovski/mini.ai",
        event = "VeryLazy",
        version = "*",
        opts = function()
            local gen_spec = require("mini.ai").gen_spec
            return {
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
            }
        end,
    },
    {
        "echasnovski/mini.icons",
        opts = {},
        config = function(opts)
            require("mini.icons").setup(opts)
            MiniIcons.mock_nvim_web_devicons()
        end,
    },
    {
        "echasnovski/mini.move",
        event = "VeryLazy",
        version = "*",
        opts = {
            mappings = {
                left = "H",
                right = "L",
                down = "J",
                up = "K",
            },
        },
    },
    {
        "echasnovski/mini.pick",
        event = "VeryLazy",
        dependencies = {
            "echasnovski/mini.extra",
        },
        opts = {
            options = {
                use_cache = true,
            },
            mappings = {
                delete_left = "",
                scroll_down = "<C-d>",
                scroll_up = "<C-u>",
            },
        },
        init = function() vim.ui.select = require("mini.pick").ui_select end,
        keys = {
            {

                "<leader>pf",
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
    },
    {
        "nvim-mini/mini.statusline",
        opts = {
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
                            trunc_width = 1e6,
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
        },
    },
}
