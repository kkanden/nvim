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
            win = {
                minimal = true,
                width = math.floor(vim.o.columns * 0.7),
                backdrop = { transparent = false },
                keys = { q = "close" },
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
                "<leader>zz",
                function() require("snacks").zen() end,
                desc = "Open zen mode",
            },
            {
                "<leader>pf",
                function() require("snacks").picker.files(opts) end,
                desc = "Snacks picker: find files",
            },
            {
                "<leader>ff",
                function()
                    require("snacks").picker.files(
                        merge_table(opts, { cwd = "~" })
                    ) -- search files in the home directory
                end,
                desc = "Snacks picker: find files",
            },
            {
                "<leader>ps",
                function() require("snacks").picker.grep(opts) end,
                desc = "Snacks picker: grep",
            },
            {
                "<leader>pb",
                function() require("snacks").picker.buffers() end,
                desc = "Snacks picker: buffers",
            },
            {
                "<leader>pn",
                function()
                    require("snacks").picker.files(
                        merge_table(opts, { cwd = vim.fn.stdpath("config") })
                    )
                end,
                desc = "Snacks picker: neovim config files",
            },
            {
                "<leader>/",
                function() require("snacks").picker.lines() end,
                desc = "[/] Fuzzily search in current buffer",
            },
            {
                "<leader>pk",
                function() require("snacks").picker.keymaps() end,
                desc = "Snacks picker: browser keymaps",
            },
            {
                "<leader>ph",
                function() require("snacks").picker.help() end,
                desc = "Snacks picker: browser help",
            },
        }
    end,
}
