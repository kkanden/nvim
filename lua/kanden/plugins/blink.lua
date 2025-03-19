local trigger = function(trigger_text)
    return function()
        local col = vim.api.nvim_win_get_cursor(0)[2]
        local before_cursor = vim.api.nvim_get_current_line():sub(1, col)
        return before_cursor:match(trigger_text) ~= nil
    end
end

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

require("blink.cmp").setup({
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
            "git",
            "conventional_commits",
            "ripgrep",
        },
        providers = {
            snippets = {
                name = "snippets",
                module = "blink.cmp.sources.snippets",
                score_offset = 1000,
                -- from linkarzu@github
                -- show snippets after typing `trigger_text`
                should_show_items = trigger(";"),
                -- After accepting the completion, delete the trigger_text characters
                -- from the final inserted text
                -- Modified transform_items function based on suggestion by `synic` so
                -- that the luasnip source is not reloaded after each transformation
                -- https://github.com/linkarzu/dotfiles-latest/discussions/7#discussion-7849902
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
            git = {
                module = "blink-cmp-git",
                name = "git",
                enabled = function() return vim.bo.filetype == "gitcommit" end,
                opts = {
                    commit = {
                        -- insert commit message instead of sha
                        get_insert_text = function(item)
                            if
                                type(item) == "table" and item.commit.message
                            then
                                return item.commit.message
                            end
                            return item:match("\n\n%s*([^\n]*)")
                        end,
                    },
                },
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
                score_offset = -10000,
            },
        },
    },
})
