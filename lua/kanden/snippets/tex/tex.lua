local M = {}
local ls = require("luasnip")
local autosnippet =
    ls.extend_decorator.apply(s, { snippetType = "autosnippet" })
local line_begin = require("luasnip.extras.conditions.expand").line_begin
local make_condition = require("luasnip.extras.conditions").make_condition

local tex = require("kanden.snippets.tex.utils").utils
local in_list = make_condition(tex.in_list)

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
local generate_cases = function(args, snip)
    local rows = tonumber(snip.captures[1]) or 2 -- default option 2 for cases
    local cols = 2 -- fix to 2 cols
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

    table.remove(nodes, #nodes)
    return sn(nil, nodes)
end
local matrix_nxn = s(
    {
        trig = "([%sbBpvV]?)mat(%d+)x(%d+)",
        snippetType = "autosnippet",
        regTrig = true,
        wordTrig = false,
        desc = "[bBpvV]matrix of A x B size",
        hidden = true,
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
local cases = autosnippet(
    {
        trig = "(%d?)cases",
        name = "cases",
        dscr = "cases",
        regTrig = true,
        hidden = true,
    },
    fmta(
        [[
    \begin{cases}
    <>
    .\end{cases}
    ]],
        { d(1, generate_cases) }
    ),

    { condition = tex.in_math, show_condition = tex.in_math }
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
                sn(nil, { r(1, ""), t(" \\colon "), i(2) }),
                sn(nil, { r(1, ""), t(" \\mid "), i(2) }),
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
    {}
)

local draft = s(
    { trig = "draft", name = "draft", dscr = "draft" },
    fmta(
        [[ 
    \documentclass{article}

    \usepackage{amssymb}
    \usepackage{amsmath}

    \begin{document}
    <>
    \end{document}
    ]],
        { i(0) }
    ),
    { condition = tex.in_preamble, show_condition = tex.in_preamble }
)

local homework = s(
    { trig = "homework", name = "homework", dscr = "homework skeleton" },
    fmta(
        [[ 
        \documentclass[12pt]{article}

        \usepackage[margin=1in]{geometry}
        \usepackage{amsmath}
        \usepackage{amssymb}
        \usepackage{float}
        \usepackage{caption}
        \usepackage{mathtools}
        \usepackage{enumitem}
        \usepackage[english]{babel}
        \usepackage{minted}
        \usepackage{fontspec}
        \usepackage{xcolor}
        \usepackage[autostyle, english=american]{csquotes}

        \MakeOuterQuote{"}
        \captionsetup[figure]{font=small,labelfont=bf}
        \floatplacement{figure}{H}
        \setmonofont{JetBrains Mono}[
          Contextuals=Alternate,
          Numbers=SlashedZero,
          Scale=MatchLowercase
        ]
        \definecolor{lightgray}{gray}{0.9}
        \setminted{
          bgcolor=lightgray,
          breaklines=true,
        }

        \renewcommand{\thesection}{\arabic{section}.}
        \DeclarePairedDelimiter{\abs}{\lvert}{\rvert}
        \DeclarePairedDelimiter{\norm}{\lVert}{\rVert}
        \DeclarePairedDelimiterX\inner[2]{\langle}{\rangle}{#1,#2}

        \title{<>}
        \author{<>}
        \date{}

        \begin{document}
        \maketitle
        <>

        \end{document}
        ]],
        { i(1), i(2), i(0) }
    ),
    { condition = tex.in_preamble, show_condition = tex.in_preamble }
)

local paired_delims = s(
    { trig = "delims", name = "delims", dscr = "Add paired delimiters" },

    fmta(
        [[ 
    \DeclarePairedDelimiter{\abs}{\lvert}{\rvert}
    \DeclarePairedDelimiter{\norm}{\lVert}{\rVert}
    \DeclarePairedDelimiterX\inner[2]{\langle}{\rangle}{#1,#2}
    <>
    ]],
        { i(0) }
    ),
    { condition = tex.in_preamble, show_condition = tex.in_preamble }
)

local insert_item = autosnippet(
    { trig = "--", name = "\\item", dscr = "\\item" },
    fmta([[\item <>]], { i(0) }),
    { condition = in_list * line_begin, show_condition = tex.in_math }
)

vim.list_extend(M, {
    matrix_nxn,
    cases,
    infty,
    imath,
    dmath,
    lr,
    lim,
    sum,
    set,
    begin_end,
    draft,
    homework,
    paired_delims,
    insert_item,
})

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
    table.insert(
        auto_backslash_snippets,
        tex.auto_backslash(
            { trig = v },
            { condition = tex.in_math, show_condition = tex.in_math }
        )
    )
end
vim.list_extend(M, auto_backslash_snippets)

-- greek letters
local greek_specs = {
    alpha = { context = { name = "α" }, command = [[\alpha]] },
    beta = { context = { name = "β" }, command = [[\beta]] },
    gam = { context = { name = "γ" }, command = [[\gamma]] },
    Gam = { context = { name = "Γ" }, command = [[\Gamma]] },
    delta = { context = { name = "δ" }, command = [[\delta]] },
    Delta = { context = { name = "Δ" }, command = [[\Delta]] },
    eps = { context = { name = "ε", priority = 500 }, command = [[\epsilon]] },
    veps = { context = { name = "ε" }, command = [[\varepsilon]] },
    zeta = { context = { name = "ζ" }, command = [[\zeta]] },
    eta = { context = { name = "η", priority = 500 }, command = [[\eta]] },
    theta = { context = { name = "θ" }, command = [[\theta]] },
    Theta = { context = { name = "Θ" }, command = [[\Theta]] },
    iota = { context = { name = "ι" }, command = [[\iota]] },
    kappa = { context = { name = "κ" }, command = [[\kappa]] },
    lambda = { context = { name = "λ" }, command = [[\lambda]] },
    Lambda = { context = { name = "Λ" }, command = [[\Lambda]] },
    mu = { context = { name = "μ" }, command = [[\mu]] },
    nu = { context = { name = "ν" }, command = [[\nu]] },
    xi = { context = { name = "ξ" }, command = [[\xi]] },
    pi = { context = { name = "π" }, command = [[\pi]] },
    rho = { context = { name = "ρ" }, command = [[\rho]] },
    sig = { context = { name = "σ" }, command = [[\sigma]] },
    Sig = { context = { name = "Σ" }, command = [[\Sigma]] },
    tau = { context = { name = "τ" }, command = [[\tau]] },
    ups = { context = { name = "υ" }, command = [[\upsilon]] },
    phi = { context = { name = "φ" }, command = [[\phi]] },
    vphi = { context = { name = "φ" }, command = [[\varphi]] },
    chi = { context = { name = "χ" }, command = [[\chi]] },
    psi = { context = { name = "Ψ" }, command = [[\psi]] },
    omega = { context = { name = "ω" }, command = [[\omega]] },
    Omega = { context = { name = "Ω" }, command = [[\Omega]] },
}

local greek_snippets = {}
for k, v in pairs(greek_specs) do
    table.insert(
        greek_snippets,
        tex.symbol_snippet(
            vim.tbl_deep_extend("keep", { trig = k }, v.context),
            v.command,
            {
                condition = tex.in_math,
                show_condition = tex.in_math,
                backslash = true,
            }
        )
    )
end
vim.list_extend(M, greek_snippets)

-- symbols
local symbol_specs = {
    -- operators
    ["!="] = { context = { name = "!=" }, command = [[\neq]] },
    ["<="] = { context = { name = "≤" }, command = [[\leq]] },
    [">="] = { context = { name = "≥" }, command = [[\geq]] },
    ["<<"] = { context = { name = "<<" }, command = [[\ll]] },
    [">>"] = { context = { name = ">>" }, command = [[\gg]] },
    ["~~"] = { context = { name = "~" }, command = [[\sim]] },

    ["~="] = { context = { name = "≈" }, command = [[\approx]] },
    ["~-"] = { context = { name = "≃" }, command = [[\simeq]] },
    ["-~"] = { context = { name = "⋍" }, command = [[\backsimeq]] },

    ["-="] = { context = { name = "≡" }, command = [[\equiv]] },
    ["=~"] = { context = { name = "≅" }, command = [[\cong]] },
    [":="] = { context = { name = "≔" }, command = [[\definedas]] },
    ["**"] = { context = { name = "·", priority = 100 }, command = [[\cdot]] },
    xx = { context = { name = "×" }, command = [[\times]] },
    ["!+"] = { context = { name = "⊕" }, command = [[\oplus]] },
    ["!*"] = { context = { name = "⊗" }, command = [[\otimes]] },
    -- sets
    NN = { context = { name = "ℕ" }, command = [[\mathbb{N}]] },
    ZZ = { context = { name = "ℤ" }, command = [[\mathbb{Z}]] },
    QQ = { context = { name = "ℚ" }, command = [[\mathbb{Q}]] },
    RR = { context = { name = "ℝ" }, command = [[\mathbb{R}]] },
    CC = { context = { name = "ℂ" }, command = [[\mathbb{C}]] },
    OO = { context = { name = "∅" }, command = [[\varnothing]] },
    pwr = { context = { name = "P" }, command = [[\powerset]] },
    cc = { context = { name = "⊂" }, command = [[\subset]] },

    cq = { context = { name = "⊆" }, command = [[\subseteq]] },
    qq = { context = { name = "⊃" }, command = [[\supset]] },
    qc = { context = { name = "⊇" }, command = [[\supseteq]] },
    ["\\\\\\"] = { context = { name = "⧵" }, command = [[\setminus]] },
    Nn = { context = { name = "∩" }, command = [[\cap]] },
    UU = { context = { name = "∪" }, command = [[\cup]] },
    ["::"] = { context = { name = ":" }, command = [[\colon]] },
    -- quantifiers and logic stuffs
    AA = { context = { name = "∀" }, command = [[\forall]] },
    EE = { context = { name = "∃" }, command = [[\exists]] },
    inn = { context = { name = "∈" }, command = [[\in]] },
    notin = { context = { name = "∉" }, command = [[\not\in]] },
    ["!-"] = { context = { name = "¬" }, command = [[\lnot]] },
    VV = { context = { name = "∨" }, command = [[\lor]] },
    WW = { context = { name = "∧" }, command = [[\land]] },
    ["!W"] = { context = { name = "∧" }, command = [[\bigwedge]] },
    ["=>"] = { context = { name = "⇒" }, command = [[\implies]] },
    ["=<"] = { context = { name = "⇐" }, command = [[\impliedby]] },
    iff = { context = { name = "⟺" }, command = [[\iff]] },
    ["->"] = { context = { name = "→", priority = 250 }, command = [[\to]] },
    ["!>"] = { context = { name = "↦" }, command = [[\mapsto]] },
    ["<-"] = { context = { name = "↦", priority = 250 }, command = [[\gets]] },
    -- differentials
    dp = { context = { name = "⇐" }, command = [[\partial]] },
    -- arrows
    ["-->"] = {
        context = { name = "⟶", priority = 500 },
        command = fmta([[\xrightarrow[<>]{<>}<>]], {
            c(1, { i(1, "below"), t("") }),
            c(2, { i(2, "above"), t("") }),
            i(0),
        }),
    },
    ["<--"] = {
        context = { name = "⟶", priority = 500 },
        command = fmta([[\xleftarrow[<>]{<>}<>]], {
            c(1, { i(1, "below"), t("") }),
            c(2, { i(2, "above"), t("") }),
            i(0),
        }),
    },
    ["<->"] = {
        context = { name = "↔", priority = 500 },
        command = [[\xleftrightarrow]],
    },
    ["->>"] = {
        context = { name = "⇉", priority = 400 },
        command = [[\rightrightarrows]],
    },
    upar = { context = { name = "↑" }, command = [[\uparrow]] },
    dnar = { context = { name = "↓" }, command = [[\downarrow]] },
    -- etc
    oo = { context = { name = "∞" }, command = [[\infty]] },
    lll = { context = { name = "ℓ" }, command = [[\ell]] },
    dag = { context = { name = "†" }, command = [[\dagger]] },
    ["+-"] = { context = { name = "†" }, command = [[\pm]] },
    ["-+"] = { context = { name = "†" }, command = [[\mp]] },
}

local symbol_snippets = {}
for k, v in pairs(symbol_specs) do
    table.insert(
        symbol_snippets,
        tex.symbol_snippet(
            vim.tbl_deep_extend("keep", { trig = k }, v.context),
            v.command,
            { condition = tex.in_math, show_condition = tex.in_math }
        )
    )
end
vim.list_extend(M, symbol_snippets)

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
