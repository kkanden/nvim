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

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Oil: Open parent directory" })

vim.keymap.set("n", "<leader>pv", "<CMD>Oil<CR>", { desc = "Oil: Open parent directory" })
vim.keymap.set(
    "n",
    "yP",
    function() yank({ modify = path_modify }) end,
    { desc = "Oil: Copy absolute file path" }
)
vim.keymap.set(
    "n",
    "yp",
    function() yank({ modify = ":." .. path_modify }) end,
    { desc = "Oil: Copy relative file path" }
)
vim.keymap.set("n", "<leader>yP", function()
    yank({ modify = path_modify })
    vim.fn.setreg("+", vim.fn.getreg(vim.v.register))
end, { desc = "Oil: Copy absolute file path in Oil to system register" })
vim.keymap.set("n", "<leader>yp", function()
    yank({ modify = ":." .. path_modify })
    vim.fn.setreg("+", vim.fn.getreg(vim.v.register))
end, { desc = "Oil: Copy relative file path in Oil to system register" })
