-- from linkarzu@github
-- show source after typing `trigger_text`
local trigger = function(trigger_text)
    return function()
        local col = vim.api.nvim_win_get_cursor(0)[2]
        local before_cursor = vim.api.nvim_get_current_line():sub(1, col)
        return before_cursor:match(trigger_text) ~= nil
    end
end

-- After accepting the completion, delete the trigger_text characters
-- from the final inserted text
-- Modified transform_items function based on suggestion by `synic` so
-- that the luasnip source is not reloaded after each transformation
-- https://github.com/linkarzu/dotfiles-latest/discussions/7#discussion-7849902
local transform_trigger = function(trigger_text)
    return function(_, items)
        local col = vim.api.nvim_win_get_cursor(0)[2]
        local before_cursor = vim.api.nvim_get_current_line():sub(1, col)
        local trigger_pos =
            before_cursor:find(trigger_text .. "[^" .. trigger_text .. "]*$")
        if trigger_pos then
            for _, item in ipairs(items) do
                if not item.trigger_text_modified then
                    ---@diagnostic disable-next-line: inject-field
                    item.trigger_text_modified = true
                    item.textEdit = {
                        newText = item.insertText or item.label,
                        range = {
                            start = {
                                line = vim.fn.line(".") - 1,
                                character = trigger_pos - 1,
                            },
                            ["end"] = {
                                line = vim.fn.line(".") - 1,
                                character = col,
                            },
                        },
                    }
                end
            end
        end
        return items
    end
end


return {
    "saghen/blink.cmp",
    version = "*",
    dependencies = {
        -- community sources
        "Kaiser-Yang/blink-cmp-git",
        "disrupted/blink-cmp-conventional-commits",
        "mikavilpas/blink-ripgrep.nvim",
        {
            "L3MON4D3/LuaSnip",
            lazy = true,
            version = "v2.*",
            dependencies = { "rafamadriz/friendly-snippets" },
            build = "make install_jsregexp",
            config = function()
                require("luasnip.loaders.from_vscode").lazy_load()
                require("luasnip.loaders.from_lua").lazy_load({
                    paths = { vim.fn.stdpath("config") .. "/snippets" },
                })

                local ls = require("luasnip")
                local map = require("kanden.lib").map

                map(
                    { "i", "s" },
                    "<Tab>",
                    function()
                        if ls.expand_or_jumpable() then ls.expand_or_jump() end
                    end,
                    {silent = true}
                )

                map(
                    { "i", "s" },
                    "<S-Tab>",
                    function() ls.jump(-1) end,
                    {silent = true}
                )

                map(
                    { "i", "s" },
                    "<C-s>",
                    function()
                        if ls.choice_active() then ls.change_choice(1) end
                    end,
                    {silent = true}
                )
            end,
        },
    },
    opts = {
        keymap = {
            ["<C-b>"] = { "select_and_accept" },
            ["<C-s>"] = { "scroll_documentation_up", "fallback" },
            ["<C-f>"] = { "scroll_documentation_down", "fallback" },
        },
        completion = {
            menu = {
                border = "rounded",
                draw = {
                    columns = {
                        { "kind_icon", "label", "label_description", gap = 1 },
                        { "kind", gap = 6 },
                        { "source_name", gap = 1 },
                    },
                },
            },
            documentation = {
                auto_show = true,
                window = {
                    border = "rounded",
                },
            },
        },
        signature = {
            enabled = true,
            window = {
                border = "rounded",
            },
        },
        cmdline = {
            enabled = true,
            completion = {
                menu = {
                    auto_show = true,
                },
            },
            keymap = {
                ["<C-b>"] = { "select_and_accept" },
            },
        },
        snippets = {
            preset = "luasnip",
        },
        sources = {
            default = {
                "lsp",
                "path",
                "snippets",
                "buffer",
                "lazydev",
                "dadbod",
                "markdown",
                "conventional_commits",
                "ripgrep",
            },
            providers = {
                lsp = {
                    name = "LSP",
                    module = "blink.cmp.sources.lsp",
                    score_offset = 10e3 - 1,
                },
                buffer = {
                    module = "blink.cmp.sources.buffer",
                    score_offset = -10e3,
                },
                snippets = {
                    name = "snippets",
                    module = "blink.cmp.sources.snippets",
                    score_offset = 10e3,
                    should_show_items = trigger(";"),
                    transform_items = transform_trigger(";"),
                },
                lazydev = {
                    name = "LazyDev",
                    module = "lazydev.integrations.blink",
                },
                dadbod = {
                    name = "Dadbod",
                    module = "vim_dadbod_completion.blink",
                },
                path = {
                    name = "path",
                    module = "blink.cmp.sources.path",
                    opts = {
                        get_cwd = function(_) return vim.fn.getcwd() end,
                        show_hidden_files_by_default = true,
                    },
                },
                markdown = {
                    name = "RenderMarkdown",
                    module = "render-markdown.integ.blink",
                    fallbacks = { "lsp" },
                },
                conventional_commits = {
                    name = "conv commit",
                    module = "blink-cmp-conventional-commits",
                    should_show_items = trigger("-"),
                    transform_items = transform_trigger("-"),
                    enabled = function() return vim.bo.filetype == "gitcommit" end,
                    score_offset = function()
                        return vim.bo.filetype == "gitcommit" and 1000 or 0
                    end,
                },
                ripgrep = {
                    name = "rg",
                    module = "blink-ripgrep",
                    fallbacks = { "buffer" },
                    score_offset = -10e4,
                },
            },
        },
    },
}
