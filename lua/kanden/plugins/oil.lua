require("oil").setup({
    skip_confirm_for_simple_edits = true,
    columns = {
        "icon",
        "size",
        "mtime",
    },
})

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
vim.keymap.set("n", "<leader>pv", "<CMD>Oil<CR>", { desc = "Open parent directory" })
