local augroup = require("kanden.lib").augroup

vim.api.nvim_create_autocmd("LspAttach", {
    group = augroup("lsp_attach"),
    callback = function(args)
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

        local map_lsp = function(keys, func, desc, mode)
            mode = mode or "n"
            vim.keymap.set(mode, keys, func, { buffer = args.buf, desc = "LSP: " .. desc })
        end

        map_lsp("K", function() vim.lsp.buf.hover() end, "Hover Documentation")
        map_lsp(
            "<C-k>",
            function() vim.lsp.buf.signature_help({ border = "single" }) end,
            "Signature Help",
            "i"
        )

        map_lsp("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
        map_lsp("grl", vim.lsp.buf.declaration, "Goto declaration")

        map_lsp(
            "gD",
            function() require("mini.extra").pickers.diagnostic() end,
            "Diagnostics"
        )

        vim.api.nvim_create_autocmd("LspProgress", {
            buffer = args.buf,
            callback = function(ev)
                local value = ev.data.params.value
                vim.api.nvim_echo({ { value.message or "done" } }, false, {
                    id = "lsp." .. ev.data.client_id,
                    kind = "progress",
                    source = "vim.lsp",
                    title = value.title,
                    status = value.kind ~= "end" and "running" or "success",
                    percent = value.percentage,
                })
            end,
        })
    end,
})

-- Global LSP configuration
vim.lsp.config("*", {
    root_markers = { ".git" },
})

-- Enable LSP's

local lsps = {}
for name, type in vim.fs.dir(vim.fn.stdpath("config") .. "/lsp") do
    if type == "file" then
        name = vim.fs.basename(name):gsub(".lua", "")
        table.insert(lsps, name)
    end
end

for _, name in pairs(lsps) do
    vim.lsp.enable(name)
end
