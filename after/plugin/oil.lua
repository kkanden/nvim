require("oil").setup({
    columns = {
        "icon",
        "size",
        "mtime",
    }
})

vim.keymap.set("n", "<leader>pv", "<CMD>Oil<CR>", { desc = "Open parent directory" })
