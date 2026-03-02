local map = require("kanden.lib").map

-- mini.ai
local gen_spec = require("mini.ai").gen_spec
require("mini.ai").setup({
    custom_textobjects = {
        -- Tweak function call to detect : (eg. `data.table::setDT()` in R)
        f = gen_spec.function_call({
            name_pattern = "[%w_%.:]",
        }),

        -- Function definition (needs treesitter queries with these captures)
        F = gen_spec.treesitter({
            a = "@function.outer",
            i = "@function.inner",
        }),
        c = gen_spec.treesitter({
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
    },
})

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
