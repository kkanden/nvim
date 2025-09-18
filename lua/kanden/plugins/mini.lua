return {
    {
        "echasnovski/mini.ai",
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
}
