local ls = require("luasnip")
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local d = ls.dynamic_node
local fmta = require("luasnip.extras.fmt").fmta
local postfix = require("luasnip.extras.postfix").postfix

local M = {}

local env = function(name)
    local is_inside = vim.fn["vimtex#env#is_inside"](name)
    return (is_inside[1] > 0 and is_inside[2] > 0)
end

M.no_backslash = function(line_to_cursor, matched_trigger)
    return not line_to_cursor:find("\\%a+$", -#line_to_cursor)
end

local ts_utils = require("kanden.snippets.tex.utils.ts_utils")

M.in_math = function() return ts_utils.in_mathzone() end

M.not_math = function() return not M.in_math() end

M.in_text = function() return env("document") and M.not_math end

M.comment = function() return vim.fn["vimtex#syntax#in_comment"]() == 1 end

M.in_preamble = function() return not env("document") end

M.get_visual = function(args, parent)
    if #parent.snippet.env.SELECT_RAW > 0 then
        return sn(nil, i(1, parent.snippet.env.SELECT_RAW))
    else -- If SELECT_RAW is empty, return a blank insert node
        return sn(nil, i(1))
    end
end

local generate_postfix_dynamicnode = function(
    _,
    parent,
    _,
    user_arg1,
    user_arg2
)
    local capture = parent.snippet.env.POSTFIX_MATCH
    if #capture > 0 then
        return sn(
            nil,
            fmta(
                [[
        <><><><>
        ]],
                { t(user_arg1), t(capture), t(user_arg2), i(0) }
            )
        )
    else
        local visual_placeholder = parent.snippet.env.SELECT_RAW
        return sn(
            nil,
            fmta(
                [[
        <><><><>
        ]],
                { t(user_arg1), i(1, visual_placeholder), t(user_arg2), i(0) }
            )
        )
    end
end

M.postfix_snippet = function(context, command, opts)
    opts = opts or {}
    if not context.trig then
        error("context doesn't include a `trig` key which is mandatory", 2)
    end
    if not context.trig then
        error("context doesn't include a `trig` key which is mandatory", 2)
    end
    context.dscr = context.dscr
    context.name = context.name or context.dscr
    context.docstring = command.pre
        .. [[(POSTFIX_MATCH|VISUAL|<1>)]]
        .. command.post
    context.match_pattern = [[[%w%.%_%-%"%']*$]]
    local j, _ = string.find(command.pre, context.trig)
    if j == 2 then
        context.trigEngine = "ecma"
        context.trig = "(?<!\\\\)" .. "(" .. context.trig .. ")"
        context.hidden = true
    end
    return postfix(context, {
        d(
            1,
            generate_postfix_dynamicnode,
            {},
            { user_args = { command.pre, command.post } }
        ),
    }, opts)
end

return M
