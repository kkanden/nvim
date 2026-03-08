local map = require("kanden.lib").map

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
})

local path_modify = ":gs?\\?/?"
local yank = require("oil.actions").yank_entry.callback

map("n", "-", "<CMD>Oil<CR>", { desc = "Oil: Open parent directory" })

map("n", "<leader>pv", "<CMD>Oil<CR>", { desc = "Oil: Open parent directory" })
map(
    "n",
    "yP",
    function() yank({ modify = path_modify }) end,
    { desc = "Oil: Copy absolute file path" }
)
map(
    "n",
    "yp",
    function() yank({ modify = ":." .. path_modify }) end,
    { desc = "Oil: Copy relative file path" }
)
map("n", "<leader>yP", function()
    yank({ modify = path_modify })
    vim.fn.setreg("+", vim.fn.getreg(vim.v.register))
end, { desc = "Oil: Copy absolute file path in Oil to system register" })
map("n", "<leader>yp", function()
    yank({ modify = ":." .. path_modify })
    vim.fn.setreg("+", vim.fn.getreg(vim.v.register))
end, { desc = "Oil: Copy relative file path in Oil to system register" })
