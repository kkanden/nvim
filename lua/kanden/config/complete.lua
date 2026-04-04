local map = require("kanden.lib").map
local augroup = require("kanden.lib").augroup

vim.o.complete = ".,w,b,F,o"
vim.o.completeopt = "popup,menuone,noinsert,fuzzy"

map({ "i", "c" }, "<C-b>", "pumvisible() ? '<C-y>' : '<C-b>'", { expr = true })

vim.o.wildmode = "full"
vim.o.wildoptions = "fuzzy"

vim.o.pumborder = "single"
vim.o.pumheight = 10
vim.o.pumwidth = 15
vim.o.pummaxwidth = 30

vim.api.nvim_create_autocmd("LspAttach", {
    group = augroup("lsp_complete"),
    callback = function(args)
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

        if client:supports_method("textDocument/completion") then
            vim.lsp.completion.enable(
                true,
                client.id,
                args.buf,
                { autotrigger = false }
            )
        end
    end,
})
