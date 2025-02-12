local map = require("kanden.lib").map
local merge_table = require("kanden.lib").merge_tables
local picker = Snacks.picker

local opts = {
    hidden = true,
    exclude = {
        ".git/",
    },
}

map(
    "n",
    "<leader>pf",
    function() picker.files(opts) end,
    { desc = "Snacks picker: find files" }
)
map("n", "<leader>ff", function()
    picker.files(merge_table(opts, { cwd = "~" })) -- search files in the home directory
end, { desc = "Snack picker: find files" })
map(
    "n",
    "<leader>ps",
    function() picker.grep(opts) end,
    { desc = "Snacks picker: grep" }
)
map("n", "<leader>pb", picker.buffers, { desc = "Snacks picker: buffers" })
map(
    "n",
    "<leader>pn",
    function()
        picker.files(merge_table(opts, { cwd = vim.fn.stdpath("config") }))
    end,
    { desc = "Snacks picker: neovim config files" }
)
map(
    "n",
    "<leader>/",
    picker.lines,
    { desc = "[/] Fuzzily search in current buffer" }
)
map(
    "n",
    "<leader>pk",
    picker.keymaps,
    { desc = "Snacks picker: browser keymaps" }
)
map("n", "<leader>ph", picker.help, { desc = "Snacks picker: browser keymaps" })

require("snacks").setup({
    picker = {
        matcher = {
            frecency = true,
            history_bonus = true,
        },
        win = {
            input = {
                keys = {
                    ["<C-b>"] = { "confirm", mode = { "n", "i" } },
                },
            },
        },
    },
})
