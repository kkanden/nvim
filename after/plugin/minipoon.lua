local minipoon = require("minipoon") -- this instantiates the minipoon object

vim.keymap.set("n", "<leader>a", function() minipoon:add_mark() end)
vim.keymap.set("n", "<C-e>", function() minipoon:toggle_window() end)
vim.keymap.set("n", "<C-c>", function() minipoon:close_window() end)

for i = 1, 4 do
    vim.keymap.set(
        "n",
        string.format("<localleader>%d", i),
        function() minipoon:open_at(i) end
    )
end
