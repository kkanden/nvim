local map = require("kanden.lib").map

return {
    "stevearc/conform.nvim",
    ---@type conform.setupOpts
    opts = {
        formatters_by_ft = {
            lua = { "stylua" },
            python = { "isort", "black" },
            r = { "air" },
            rust = { "rustfmt" },
            json = { "prettier" },
            yaml = { "prettier" },
            yml = { "prettier" },
            toml = { "prettier" },
            nix = { "nixfmt" },
            markdown = { "prettier", "injected" },
            rmd = { "prettier", "injected" },
            tex = { "tex-fmt" },
            bib = { "tex-fmt" },
        },
        formatters = {
            isort = {
                command = "isort",
                args = {
                    "-",
                },
            },
            black = {
                command = "black",
                append_args = { "--preview" },
            },
            prettier = {
                append_args = function(_, ctx)
                    if vim.bo[ctx.buf].filetype == "toml" then
                        return {
                            "--parser=toml",
                            "--plugin=prettier-plugin-toml",
                        }
                    end
                    return {}
                end,
                options = {
                    ext_parsers = {
                        rmd = "markdown",
                    },
                },
            },
            injected = {
                options = {
                    ignore_erros = true,
                },
            },
        },
        format_after_save = function(bufnr)
            if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                return
            end
            return { timeout_ms = 2000, lsp_format = "fallback" }
        end,
    },
    init = function()
        map("n", "<leader>fm", function(bufnr)
            require("conform").format({
                bufnr = bufnr,
                timeout_ms = 10000,
                async = true,
                lsp_format = "fallback",
            })
            vim.cmd("w")
        end, { desc = "[F]ormat Code" })

        -- Commands to disable/enable autoformat
        vim.api.nvim_create_user_command("FormatDisable", function(args)
            if args.bang then
                -- FormatDisable! will disable formatting just for this buffer
                vim.b.disable_autoformat = true
            else
                vim.g.disable_autoformat = true
            end
        end, {
            desc = "Disable autoformat-on-save",
            bang = true,
        })

        vim.api.nvim_create_user_command("FormatEnable", function()
            vim.b.disable_autoformat = false
            vim.g.disable_autoformat = false
        end, {
            desc = "Re-enable autoformat-on-save",
        })

        vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
}
