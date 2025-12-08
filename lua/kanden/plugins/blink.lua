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
    event = "VeryLazy",
    version = "*",
    dependencies = {
        -- community sources
        "mikavilpas/blink-ripgrep.nvim",

        -- snippets
        "L3MON4D3/LuaSnip",
    },
    opts = {
        keymap = {
            ["<C-b>"] = { "select_and_accept" },
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
            trigger = {
                show_on_keyword = true,
                show_on_insert = true,
            },
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
                    -- should_show_items = trigger(";"),
                    -- transform_items = transform_trigger(";"),
                },
                lazydev = {
                    name = "LazyDev",
                    module = "lazydev.integrations.blink",
                    score_offset = 10e3,
                },
                path = {
                    name = "path",
                    module = "blink.cmp.sources.path",
                    score_offset = 10e3 + 1,
                    opts = {
                        get_cwd = function(_) return vim.fn.getcwd() end,
                        show_hidden_files_by_default = true,
                    },
                },
                ripgrep = {
                    name = "rg",
                    module = "blink-ripgrep",
                    fallbacks = { "buffer" },
                    score_offset = -10e4,
                    transform_items = function(_, items)
                        for _, item in ipairs(items) do
                            item.kind_name = nil
                        end
                        return items
                    end,
                },
            },
        },
    },
}
