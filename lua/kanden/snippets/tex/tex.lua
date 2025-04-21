local M = {}
local ls = require("luasnip")
local autosnippet =
    ls.extend_decorator.apply(s, { snippetType = "autosnippet" })
local line_begin = require("luasnip.extras.conditions.expand").line_begin

local tex = require("kanden.snippets.tex.utils").utils

-- object shortcuts
local character_shortcut = function(trig, command, desc)
    return autosnippet({
        trig = trig,
        desc = desc,
        wordTrig = false,
    }, { t(command) })
end

local infty = character_shortcut(";i", "\\infty", "infinity")

local imath = autosnippet(
    { trig = "mk", name = "$...$", desc = "inline math" },
    fmta(
        [[
        $ <> $<>
        ]],
        { i(1), i(0) }
    )
)

local dmath = autosnippet(
    { trig = "dm", name = "\\[...\\]", desc = "display math" },
    fmta(
        [[ 
    \[ 
        <>
    \]
    <>]],
        { i(1), i(0) }
    ),
    { condition = line_begin }
)

local generate_matrix = function(args, snip)
    local rows = tonumber(snip.captures[2])
    local cols = tonumber(snip.captures[3])
    local nodes = {}
    local ins_indx = 1
    for j = 1, rows do
        table.insert(nodes, r(ins_indx, tostring(j) .. "x1", i(1)))
        ins_indx = ins_indx + 1
        for k = 2, cols do
            table.insert(nodes, t(" & "))
            table.insert(
                nodes,
                r(ins_indx, tostring(j) .. "x" .. tostring(k), i(1))
            )
            ins_indx = ins_indx + 1
        end
        table.insert(nodes, t({ "\\\\", "" }))
    end
    -- fix last node.
    nodes[#nodes] = t("\\\\")
    return sn(nil, nodes)
end
local matrix_nxn = s(
    {
        trig = "([%sbBpvV]?)Mat(%d+)x(%d+)",
        snippetType = "autosnippet",
        regTrig = true,
        wordTrig = false,
        desc = "[bBpvV]matrix of A x B size",
    },
    fmta(
        [[
    \begin{<>}
    <>
    \end{<>}]],
        {
            f(function(_, snip)
                if snip.captures[1] == " " or snip.captures[1] == nil then
                    print(snip.captures[1])
                    return "matrix"
                else
                    return snip.captures[1] .. "matrix"
                end
            end),
            d(1, generate_matrix),
            f(function(_, snip)
                if snip.captures[1] == " " or snip.captures[1] == nil then
                    return "matrix"
                else
                    return snip.captures[1] .. "matrix"
                end
            end),
        }
    ),
    { condition = tex.in_math }
)

-- delimiters
local delims = {
    a = { "\\langle", "\\rangle" },
    A = { "Angle", "Angle" },
    b = { "brack", "brack" },
    B = { "Brack", "Brack" },
    c = { "brace", "brace" },
    m = { "|", "|" },
    p = { "(", ")" },
}
local lr = autosnippet(
    {
        trig = "lr([aAbBcmp])",
        name = "left right",
        dscr = "left right delimiters",
        regTrig = true,
        hidden = true,
    },
    fmta(
        [[
    \left<> <> \right<><>
    ]],
        {
            f(function(_, snip)
                local cap = snip.captures[1] or "p"
                return delims[cap][1]
            end),
            d(1, tex.get_visual),
            f(function(_, snip)
                local cap = snip.captures[1] or "p"
                return delims[cap][2]
            end),
            i(0),
        }
    ),
    { condition = tex.in_math, show_condition = tex.in_math }
)

-- math commands
local lim = autosnippet(
    { trig = "lim", name = "lim(sup|inf)", dscr = "lim(sup|inf)" },
    fmta(
        [[ 
    \lim<><><>
    ]],
        {
            c(1, { t(""), t("sup"), t("inf") }),
            c(2, {
                t(""),
                fmta([[_{<> \to <>}]], { i(1, "n"), i(2, "\\infty") }),
            }),
            i(0),
        }
    ),
    { condition = tex.in_math, show_condition = tex.in_math }
)

local sum = autosnippet(
    { trig = "sum", name = "summation", dscr = "summation" },
    fmta(
        [[
    \sum<> <>
    ]],
        {
            c(1, {
                fmta([[_{<>}^{<>}]], { i(1, "i = 0"), i(2, "\\infty") }),
                t(""),
            }),
            i(0),
        }
    ),
    { condition = tex.in_math, show_condition = tex.in_math }
)

local set = autosnippet(
    { trig = "set", name = "set", dscr = "set" }, -- overload with set builders notation because analysis and algebra cannot agree on a singular notation
    fmta(
        [[
    \{<>\}<>
    ]],
        {
            c(1, {
                r(1, ""),
                sn(nil, { r(1, ""), t(" \\mid "), i(2) }),
                sn(nil, { r(1, ""), t(" \\colon "), i(2) }),
            }),
            i(0),
        }
    ),
    { condition = tex.in_math, show_condition = tex.in_math }
)

-- environments
local begin_end = s(
    {
        trig = "beg",
        name = "begin/end",
        dscr = "begin/end environment (generic)",
    },
    fmta(
        [[
    \begin{<>}
    <>
    \end{<>}
    ]],
        { i(1), i(0), rep(1) }
    ),
    { condition = tex.in_text, show_condition = tex.in_text }
)

local draft = s(
    { trig = "draft", name = "draft", dscr = "draft" },
    fmta(
        [[ 
    \documentclass{article}

    \begin{document}
    <>
    \end{document}
    ]],
        { i(0) }
    ),
    { condition = tex.not_math, show_condition = tex.not_math }
)

vim.list_extend(M, {
    matrix_nxn,
    infty,
    imath,
    dmath,
    lr,
    lim,
    sum,
    set,
    begin_end,
    draft,
})

local auto_backslash_snippet = function(trig)
    return autosnippet(
        {
            trig = trig,
            desc = trig .. " with auto backslash",
        },
        fmta(
            [[
\<><>
        ]],
            { t(trig), i(0) }
        ),
        { condition = tex.in_math, show_condition = tex.in_math }
    )
end
local auto_backslash_specs = {
    "arcsin",
    "sin",
    "arccos",
    "cos",
    "arctan",
    "tan",
    "cot",
    "csc",
    "sec",
    "log",
    "ln",
    "exp",
    "ast",
    "star",
    "perp",
    "sup",
    "inf",
    "det",
    "max",
    "min",
    "argmax",
    "argmin",
    "deg",
    "angle",
}

local auto_backslash_snippets = {}
for _, v in ipairs(auto_backslash_specs) do
    table.insert(auto_backslash_snippets, auto_backslash_snippet(v))
end
vim.list_extend(M, auto_backslash_snippets)

-- postifx
local postfix_math_specs = {
    mbb = {
        context = {
            name = "mathbb",
            dscr = "math blackboard bold",
        },
        command = {
            pre = [[\mathbb{]],
            post = [[}]],
        },
    },
    mcal = {
        context = {
            name = "mathcal",
            dscr = "math calligraphic",
        },
        command = {
            pre = [[\mathcal{]],
            post = [[}]],
        },
    },
    mscr = {
        context = {
            name = "mathscr",
            dscr = "math script",
        },
        command = {
            pre = [[\mathscr{]],
            post = [[}]],
        },
    },
    mfr = {
        context = {
            name = "mathfrak",
            dscr = "mathfrak",
        },
        command = {
            pre = [[\mathfrak{]],
            post = [[}]],
        },
    },
    hat = {
        context = {
            name = "hat",
            dscr = "hat",
        },
        command = {
            pre = [[\hat{]],
            post = [[}]],
        },
    },
    bar = {
        context = {
            name = "bar",
            dscr = "bar (overline)",
        },
        command = {
            pre = [[\overline{]],
            post = [[}]],
        },
    },
    tld = {
        context = {
            name = "tilde",
            priority = 500,
            dscr = "tilde",
        },
        command = {
            pre = [[\tilde{]],
            post = [[}]],
        },
    },
}

local postfix_math_snippets = {}
for k, v in pairs(postfix_math_specs) do
    table.insert(
        postfix_math_snippets,
        tex.postfix_snippet(
            vim.tbl_deep_extend(
                "keep",
                { trig = k, snippetType = "autosnippet" },
                v.context
            ),
            v.command,
            { condition = tex.in_math, show_condition = tex.in_math }
        )
    )
end
vim.list_extend(M, postfix_math_snippets)

return M
