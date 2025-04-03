return {
    "echasnovski/mini.ai",
    version = "*",
    opts = function()
        local gen_spec = require("mini.ai").gen_spec
        return {
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
        }
    end,
}
