local path_modify = ":gs?\\?/?"

return {
    "stevearc/oil.nvim",
    lazy = false,
    ---@module 'oil'
    ---@type oil.SetupOpts
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
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
        delete_to_trash = true,
    },
    keys = {
        { "-", "<CMD>Oil<CR>", desc = "Open parent directory" },

        { "<leader>pv", "<CMD>Oil<CR>", desc = "Open parent directory" },
        {
            "yP",
            function()
                require("oil.actions").yank_entry.callback({
                    modify = path_modify,
                })
            end,
            desc = "Copy absolute file path in Oil",
        },
        {
            "yp",
            function()
                require("oil.actions").yank_entry.callback({
                    modify = ":." .. path_modify,
                })
            end,
            desc = "Copy relative file path in Oil",
        },
        {
            "<leader>yP",
            function()
                require("oil.actions").yank_entry.callback({
                    modify = path_modify,
                })
                vim.fn.setreg("+", vim.fn.getreg(vim.v.register))
            end,
            desc = "Copy absolute file path in Oil to system register",
        },
        {
            "<leader>yp",
            function()
                require("oil.actions").yank_entry.callback({
                    modify = ":." .. path_modify,
                })
                vim.fn.setreg("+", vim.fn.getreg(vim.v.register))
            end,
            desc = "Copy relative file path in Oil to system register",
        },
    },
}
