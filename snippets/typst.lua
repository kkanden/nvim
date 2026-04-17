---@diagnostic disable: undefined-global

local autosnippet = require("luasnip").extend_decorator.apply(
    s,
    { snippetType = "autosnippet" }
)
return {

    autosnippet(
        { trig = "mk" },
        fmta(
            [[
        $<>$ <>
        ]],
            { i(1), i(0) }
        )
    ),
    autosnippet(
        { trig = "dm" },
        fmta("$ <> $ <> ", { i(1), i(0) }),
        { condition = line_begin }
    ),
}
