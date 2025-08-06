local augroup = require("kanden.lib").augroup
local map = require("kanden.lib").map
local complete_fun = require("kanden.lib").user_cmd_complete

vim.api.nvim_create_autocmd("LspAttach", {
    group = augroup("lsp_attach"),
    callback = function(args)
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

        local map_lsp = function(keys, func, desc, mode)
            mode = mode or "n"
            map(mode, keys, func, { buffer = args.buf, desc = "LSP: " .. desc })
        end

        map_lsp(
            "K",
            function() vim.lsp.buf.hover({ border = "rounded" }) end,
            "Hover Documentation"
        )
        map_lsp(
            "<C-k>",
            function() vim.lsp.buf.signature_help({ border = "rounded" }) end,
            "Signature Help",
            "i"
        )

        -- Jump to the definition of the word under your cursor.
        --  This is where a variable was first declared, or where a function is defined, etc.
        --  To jump back, press <C-t>.
        map_lsp(
            "gd",
            function()
                require("mini.extra").pickers.lsp({ scope = "definition" })
            end,
            "[G]oto [D]efinition"
        )

        -- Find references for the word under your cursor.
        map_lsp(
            "grr",
            function()
                require("mini.extra").pickers.lsp({ scope = "references" })
            end,
            "[G]oto [R]eferences"
        )

        -- Jump to the implementation of the word under your cursor.
        --  Useful when your language has ways of declaring types without an actual implementation.
        map_lsp(
            "gri",
            function()
                require("mini.extra").pickers.lsp({ scope = "implementation" })
            end,
            "[G]oto [I]mplementation"
        )

        -- Fuzzy find all the symbols in your current document.
        --  Symbols are things like variables, functions, types, etc.
        map_lsp(
            "gs",
            function()
                require("mini.extra").pickers.lsp({ scope = "document_symbol" })
            end,
            "Document [S]ymbols"
        )

        -- Fuzzy find all the symbols in your current workspace.
        --  Similar to document symbols, except searches over your entire project.
        map_lsp(
            "gws",
            function()
                require("mini.extra").pickers.lsp({ scope = "workspace_symbol" })
            end,
            "[W]orkspace [S]ymbols"
        )

        map_lsp(
            "gD",
            function() require("mini.extra").pickers.diagnostic() end,
            "Diagnostics"
        )

        -- Move to next/prev diagnostic
        local min_severity = vim.bo.filetype == "r"
                and vim.diagnostic.severity.ERROR
            or vim.diagnostic.severity.WARN
        map_lsp(
            "g]",
            function()
                vim.diagnostic.jump({
                    severity = min_severity,
                    count = 1,
                })
            end,
            "Go to next diagnostic"
        )

        map_lsp(
            "g[",
            function()
                vim.diagnostic.jump({
                    severity = min_severity,
                    count = -1,
                })
            end,
            "Go to previous diagnostic"
        )
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

local load_lsps = function()
    for _, name in pairs(lsps) do
        if name == "nixd" and vim.fn.has("win32") == 1 then goto continue end
        vim.lsp.enable(name)
        ::continue::
    end
end

load_lsps()

vim.api.nvim_create_user_command("LspRestart", function()
    vim.lsp.stop_client(vim.lsp.get_clients())
    vim.wait(500)
    load_lsps()
    vim.cmd("wa")
    vim.cmd("edit")
    vim.api.nvim_feedkeys("zz", "n", false)
end, {})

vim.api.nvim_create_user_command(
    "LspEnable",
    function(opts) vim.lsp.enable(opts.fargs) end,
    { nargs = "+", complete = complete_fun(lsps) }
)

map("n", "<leader>zig", "<Cmd>LspRestart<CR>", { desc = "Restart LSP" })
