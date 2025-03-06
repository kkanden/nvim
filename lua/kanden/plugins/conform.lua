local map = require("kanden.lib").map

require("conform").setup({
    formatters_by_ft = {
        lua = { "stylua" },
        python = { "isort", "black" },
        r = { "air" },
        rust = { "rustfmt" },
        json = { "prettier" },
        yaml = { "prettier" },
        yml = { "prettier" },
        toml = { "prettier" },
        nix = { "alejandra" },
    },
    formatters = {
        isort = {
            command = "isort",
            args = {
                "-",
            },
        },
    },
    format_after_save = function(bufnr)
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            return
        end
        return { timeout_ms = 2000, lsp_format = "fallback" }
    end,
})

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
