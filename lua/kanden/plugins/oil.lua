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
    "<localleader>h",
    function() require("oil").open("~") end,
    { desc = "Open home directory" }
)

local path_sep_replace = ":gs?\\?/?"
map(
    "n",
    "yP",
    function()
        require("oil.actions").yank_entry.callback({ modify = path_sep_replace })
    end,
    { desc = "Copy absolute file path in Oil" }
)
map(
    "n",
    "yp",
    function()
        require("oil.actions").yank_entry.callback({
            modify = ":." .. path_sep_replace,
        })
    end,
    { desc = "Copy relative file path in Oil" }
)
map("n", "<leader>yP", function()
    require("oil.actions").yank_entry.callback({ modify = path_sep_replace })
    vim.fn.setreg("+", vim.fn.getreg(vim.v.register))
end, { desc = "Copy absolute file path in Oil to system register" })
map("n", "<leader>yp", function()
    require("oil.actions").yank_entry.callback({
        modify = ":." .. path_sep_replace,
    })
    vim.fn.setreg("+", vim.fn.getreg(vim.v.register))
end, { desc = "Copy relative file path in Oil to system register" })
