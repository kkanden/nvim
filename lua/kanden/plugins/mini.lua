local map = require("kanden.lib").map

-- mini.ai
local ts_input = require("mini.ai").gen_spec.treesitter
require("mini.ai").setup({
    custom_textobjects = {
        -- Tweak function call to detect : (eg. `data.table::setDT()` in R)
        f = ts_input({
            a = "@call.outer",
            i = "@call.inner",
        }),

        -- Function definition (needs treesitter queries with these captures)
        F = ts_input({
            a = "@function.outer",
            i = "@function.inner",
        }),
        c = ts_input({
            a = "@conditional.outer",
            i = "@conditional.inner",
        }),
    },
})

-- mini.move
require("mini.move").setup({
    mappings = {
        left = "H",
        right = "L",
        down = "J",
        up = "K",

        line_left = "",
        line_right = "",
        line_down = "",
        line_up = "",
    },
})

-- mini.surround
local ts_input = require("mini.surround").gen_spec.input.treesitter
require("mini.surround").setup({
    custom_surroundings = {
        f = {
            input = ts_input({ outer = "@call.outer", inner = "@call.inner" }),
        },
        F = {
            input = ts_input({
                outer = "@function.outer",
                inner = "@function.inner",
            }),
        },
    },
    mappings = {
        add = "ys",
        delete = "ds",
        replace = "cs",
        find = "",
        find_left = "",
        highlight = "",
        suffix_last = "",
        suffix_next = "",
    },
    search_method = "cover_or_next",
})

vim.keymap.del("x", "ys")
map("x", "S", [[:<C-u>lua MiniSurround.add('visual')<CR>]], { silent = true })
map("n", "yss", "ys_", { remap = true })

-- mini.pick
require("mini.pick").setup({
    options = {
        use_cache = true,
    },
    mappings = {
        delete_left = "",
        scroll_down = "<C-d>",
        scroll_up = "<C-u>",
        choose_2 = {
            char = "<C-b>",
            func = function()
                local cur_item =
                    require("mini.pick").get_picker_matches().current
                local choose =
                    require("mini.pick").get_picker_opts().source.choose
                choose(cur_item)
                return true
            end,
        },
    },
})
vim.ui.select = require("mini.pick").ui_select

map(
    "n",
    "ff",
    function() require("mini.pick").builtin.files() end,
    { desc = "mini.pick: files" }
)
map(
    "n",
    "<leader>pn",
    function()
        require("mini.pick").builtin.files(
            nil,
            { source = { cwd = vim.fn.stdpath("config") } }
        )
    end,
    { desc = "mini,pick: nvim config files" }
)
map(
    "n",
    "<leader>ps",
    function() require("mini.pick").builtin.grep_live() end,
    { desc = "mini.pick: grep" }
)
map(
    "n",
    "<leader>pb",
    function() require("mini.pick").builtin.buffers() end,
    { desc = "mini.pick: buffers" }
)
map(
    "n",
    "<leader>ph",
    function() require("mini.pick").builtin.help() end,
    { desc = "mini.pick: help" }
)
map(
    "n",
    "<leader>pk",
    function() require("mini.extra").pickers.keymaps() end,
    { desc = "mini.pick: keymaps" }
)
