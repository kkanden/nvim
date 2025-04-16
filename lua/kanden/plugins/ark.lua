return {
    "wurli/ark.nvim",
    filetypes = "r",
    dependencies = { "blink.cmp" },
    config = function()
        require("ark").setup({
            lsp_capabilities = require("blink.cmp").get_lsp_capabilities(),
            auto_start = false,
        })

        vim.api.nvim_create_user_command(
            "ArkStartLsp",
            function() require("ark").start_lsp() end,
            {}
        )

        -- vim.api.nvim_create_autocmd("FileType", {
        --     pattern = { "r" },
        --     callback = function()
        vim.keymap.set(
            { "n", "v" },
            "<localleader>l",
            function()
                require("ark").execute_current()
            end,
            { buffer = 0, desc = "Send code to the R console" }
        )
        -- end,
        -- })

        -- vim.api.nvim_create_autocmd("BufEnter", {
        --     pattern = { "*.r", "*.R" },
        --     callback = function() require("ark").start_lsp() end,
        -- })
    end,
}
