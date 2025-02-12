local map = require("kanden.lib.nvim_api").map
local picker = Snacks.picker

map("n", "<leader>pf", picker.files, { desc = "Snacks picker: find files" })
map("n", "<leader>ff", function()
    picker.files({ cwd = "~" }) -- search files in the home directory
end, { desc = "Snack picker: find files" })
map("n", "<leader>ps", picker.grep, { desc = "Snacks picker: grep" })
map("n", "<leader>pb", picker.buffers, { desc = "Snacks picker: buffers" })
map(
    "n",
    "<leader>pn",
    function() picker.files({ cwd = vim.fn.stdpath("config") }) end,
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
