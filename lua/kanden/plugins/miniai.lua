return {
    "echasnovski/mini.ai",
    version = "*",
    config = function()
        require("mini.ai").setup({
            custom_textobjects = {
                -- Tweak function call to detect : (eg. `data.table::setDT()` in R)
                f = require("mini.ai").gen_spec.function_call({
                    name_pattern = "[%w_%.:]",
                }),

                -- Function definition (needs treesitter queries with these captures)
                F = require("mini.ai").gen_spec.treesitter({
                    a = "@function.outer",
                    i = "@function.inner",
                }),
                c = require("mini.ai").gen_spec.treesitter({
                    a = "@conditional.outer",
                    i = "@conditional.inner",
                }),
            },
        })
    end,
}
