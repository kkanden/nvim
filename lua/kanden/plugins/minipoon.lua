local map = require("kanden.lib").map
return {
    "kkanden/minipoon.nvim",
    dev = true,
    init = function()
        local minipoon = require("minipoon")
        map("n", "<leader>a", function() minipoon:add_mark() end)
        map("n", "<C-e>", function() minipoon:toggle_window() end)
        map("n", "<C-c>", function() minipoon:close_window() end)

        for i = 1, 4 do
            map(
                "n",
                string.format("<localleader>%d", i),
                function() minipoon:open_at(i) end
            )
        end
    end,
}
