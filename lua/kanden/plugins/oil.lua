local map = require("kanden.lib.nvim_api").map
require("oil").setup({
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
})

map("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
map("n", "<leader>pv", "<CMD>Oil<CR>", { desc = "Open parent directory" })
map(
    "n",
    "yP",
    function() require("oil.actions").yank_entry.callback() end,
    { desc = "Copy absolute file path in Oil" }
)
map(
    "n",
    "yp",
    function() require("oil.actions").yank_entry.callback({ modify = ":." }) end,
    { desc = "Copy relative file path in Oil" }
)
map("n", "<leader>yP", function()
    require("oil.actions").yank_entry.callback()
    vim.fn.setreg("+", vim.fn.getreg(vim.v.register))
end, { desc = "Copy absolute file path in Oil to system register" })
map("n", "<leader>yp", function()
    require("oil.actions").yank_entry.callback({ modify = ":." })
    vim.fn.setreg("+", vim.fn.getreg(vim.v.register))
end, { desc = "Copy relative file path in Oil to system register" })
