local merge_table = function(...) return vim.tbl_extend("keep", ...) end

return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
        picker = {
            matcher = {
                frecency = true,
                history_bonus = true,
            },
            win = {
                input = {
                    keys = {
                        ["<C-b>"] = { "confirm", mode = { "n", "i" } },
                        ["<C-k>"] = { "history_back", mode = { "n", "i" } },
                        ["<C-j>"] = { "history_forward", mode = { "n", "i" } },
                    },
                },
            },
        },
        input = {
            enabled = true,
        },
        zen = {
            toggles = {
                dim = false,
            },
        },
        styles = {
            zen = {
                minimal = true,
            },
        },
    },
    keys = function()
        local opts = {
            hidden = true,
            exclude = {
                ".git/",
            },
        }
        return {
            {
                "<leader>pf",
                function() Snacks.picker.files(opts) end,
                desc = "Snacks picker: find files",
            },
            {
                "<leader>ff",
                function()
                    Snacks.picker.files(merge_table(opts, { cwd = "~" })) -- search files in the home directory
                end,
                desc = "Snacks picker: find files",
            },
            {
                "<leader>ps",
                function() Snacks.picker.grep(opts) end,
                desc = "Snacks picker: grep",
            },
            {
                "<leader>pb",
                function() Snacks.picker.buffers() end,
                desc = "Snacks picker: buffers",
            },
            {
                "<leader>pn",
                function()
                    Snacks.picker.files(
                        merge_table(opts, { cwd = vim.fn.stdpath("config") })
                    )
                end,
                desc = "Snacks picker: neovim config files",
            },
            {
                "<leader>/",
                function() Snacks.picker.lines() end,
                desc = "[/] Fuzzily search in current buffer",
            },
            {
                "<leader>pk",
                function() Snacks.picker.keymaps() end,
                desc = "Snacks picker: browser keymaps",
            },
            {
                "<leader>ph",
                function() Snacks.picker.help() end,
                desc = "Snacks picker: browser help",
            },
        }
    end,
}
