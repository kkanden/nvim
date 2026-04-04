local map = require("kanden.lib").map
local augroup = require("kanden.lib").augroup
map({ "i", "c" }, "<C-b>", "pumvisible() ? '<C-y>' : '<C-b>'", { expr = true })

-- cmdline autocomplete
vim.cmd([[autocmd CmdlineChanged [:\/\?] call wildtrigger()]])

vim.api.nvim_create_autocmd("LspAttach", {
    group = augroup("lsp_complete"),
    callback = function(args)
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

        if client:supports_method("textDocument/completion") then
            vim.lsp.completion.enable(
                true,
                client.id,
                args.buf,
                { autotrigger = true }
            )
        end
    end,
})
