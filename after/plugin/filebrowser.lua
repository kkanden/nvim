require("telescope").load_extension("file_browser")

vim.keymap.set("n", "<leader>pd", ":Telescope file_browser<CR>")
