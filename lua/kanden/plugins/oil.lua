return {
    "stevearc/oil.nvim",
    lazy = false,
    priority = 10e3,
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
        skip_confirm_for_simple_edits = true,
        columns = {
            "icon",
            "size",
            "mtime",
        },
        keymaps = {
            ["<C-s>"] = false,
            ["<C-h>"] = false,
            ["<C-t>"] = false,
            ["<C-l>"] = false,
        },
    },
    keys = function()
        local path_modify = ":gs?\\?/?"
        local yank = require("oil.actions").yank_entry.callback

        return {
            { "-", "<CMD>Oil<CR>", desc = "Oil: Open parent directory" },

            {
                "<leader>pv",
                "<CMD>Oil<CR>",
                desc = "Oil: Open parent directory",
            },
            {
                "yP",
                function() yank({ modify = path_modify }) end,
                desc = "Oil: Copy absolute file path",
            },
            {
                "yp",
                function() yank({ modify = ":." .. path_modify }) end,
                desc = "Oil: Copy relative file path",
            },
            {
                "<leader>yP",
                function()
                    yank({ modify = path_modify })
                    vim.fn.setreg("+", vim.fn.getreg(vim.v.register))
                end,
                desc = "Oil: Copy absolute file path in Oil to system register",
            },
            {
                "<leader>yp",
                function()
                    yank({ modify = ":." .. path_modify })
                    vim.fn.setreg("+", vim.fn.getreg(vim.v.register))
                end,
                desc = "Oil: Copy relative file path in Oil to system register",
            },
        }
    end,
}
