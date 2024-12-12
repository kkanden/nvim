local harpoon = require("harpoon")

harpoon:setup()

local toggle_opts = {
    title = " Harpoon ",
    border = "rounded",
    title_pos = "center",
    ui_width_ratio = 0.4,
}

vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list(), toggle_opts) end)
vim.keymap.set("n", "<C-c>", function() harpoon.ui:close_menu() end)

vim.keymap.set("n", "w1", function() harpoon:list():select(1) end)
vim.keymap.set("n", "w2", function() harpoon:list():select(2) end)
vim.keymap.set("n", "w3", function() harpoon:list():select(3) end)
vim.keymap.set("n", "w4", function() harpoon:list():select(4) end)
