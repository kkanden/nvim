local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local d = ls.dynamic_node
local f = ls.function_node
local fmta = require("luasnip.extras.fmt").fmta
local postfix = require("luasnip.extras.postfix").postfix
local autosnippet =
    ls.extend_decorator.apply(s, { snippetType = "autosnippet" })

local M = {}

M.in_env = function(name)
    local is_inside = vim.fn["vimtex#env#is_inside"](name)
    return (is_inside[1] > 0 and is_inside[2] > 0)
end

M.no_backslash = function(line_to_cursor, matched_trigger)
    return not line_to_cursor:find("\\%a+$", -#line_to_cursor)
end

local ts_utils = require("kanden.snippets.tex.utils.ts_utils")

M.in_math = function() return ts_utils.in_mathzone() end

M.not_math = function() return not M.in_math() end

M.in_text = function() return M.in_env("document") and M.not_math end

M.comment = function() return vim.fn["vimtex#syntax#in_comment"]() == 1 end

M.in_preamble = function() return not M.in_env("document") end

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
    context.dscr = context.dscr
    context.name = context.name or context.dscr
    context.docstring = command.pre
        .. [[(POSTFIX_MATCH|VISUAL|<1>)]]
        .. command.post
    context.match_pattern = [[[%w%.%_%-%"%'\\]*$]]
    context.trigEngine = "ecma"
    context.trig = string.format("(?<!\\\\)(%s)", context.trig)
    context.hidden = true
    return postfix(context, {
        d(
            1,
            generate_postfix_dynamicnode,
            {},
            { user_args = { command.pre, command.post } }
        ),
    }, opts)
end

M.auto_backslash = function(context, opts)
    opts = opts or {}
    if not context.trig then
        error("context doesn't include a `trig` key which is mandatory", 2)
    end
    context.dscr = context.dscr or (context.trig .. "with automatic backslash")
    context.name = context.name or context.trig
    context.docstring = context.docstring or ([[\]] .. context.trig)
    context.trigEngine = "ecma"
    context.trig = string.format("(?<!\\\\)(%s)", context.trig)
    return autosnippet(
        context,
        fmta(
            [[\<><>]],
            { f(function(_, snip) return snip.captures[1] end), i(0) }
        ),
        opts
    )
end

M.symbol_snippet = function(context, command, opts)
    opts = opts or {}
    if not context.trig then
        error("context doesn't include a `trig` key which is mandatory", 2)
    end
    context.name = context.name or command:gsub([[\]], "")
    context.dscr = context.dscr or context.name
    context.docstring = context.docstring or context.name
    context.wordTrig = context.wordTrig or false
    local exec = command
    if type(command) == "string" then -- if it's string, take it literally
        local j, _ = string.find(command, context.trig)
        if j == 2 then -- command always starts with backslash
            context.trigEngine = "ecma"
            context.trig = string.format("(?<!\\\\)(%s)", context.trig)
            context.hidden = true
        end
        exec = t(command)
    end
    return autosnippet(context, exec, opts)
end

return M
