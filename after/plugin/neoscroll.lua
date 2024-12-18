local neoscroll = require("neoscroll")
neoscroll.setup({
    mappings = {},
})

local keymap = {
    ["<C-u>"] = function()
        neoscroll.ctrl_u({ duration = 1 })
        vim.fn.feedkeys("zz", "n")
    end,
    ["<C-d>"] = function()
        neoscroll.ctrl_d({ duration = 1 })
        vim.fn.feedkeys("zz", "n")
    end,
    ["zt"]    = function() neoscroll.zt({ half_win_duration = 10 }) end,
    ["zz"]    = function() neoscroll.zz({ half_win_duration = 10 }) end,
    ["zb"]    = function() neoscroll.zb({ half_win_duration = 10 }) end,
}

local modes = { "n", "v", "x" }
for key, func in pairs(keymap) do
    vim.keymap.set(modes, key, func)
end
