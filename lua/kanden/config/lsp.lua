local augroup = require("kanden.lib").augroup
local map = require("kanden.lib").map
local picker = Snacks.picker

-- This is where you enable features that only work
-- if there is a language server active in the file
vim.api.nvim_create_autocmd("LspAttach", {
    group = augroup("lsp_attach"),
    callback = function(args)
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

        local map_lsp = function(keys, func, desc, mode)
            mode = mode or "n"
            map(mode, keys, func, { buffer = args.buf, desc = "LSP: " .. desc })
        end
        -- Jump to the definition of the word under your cursor.
        --  This is where a variable was first declared, or where a function is defined, etc.
        --  To jump back, press <C-t>.
        map_lsp("gd", picker.lsp_definitions, "[G]oto [D]efinition")

        -- Find references for the word under your cursor.
        map_lsp("grr", picker.lsp_references, "[G]oto [R]eferences")

        -- Jump to the implementation of the word under your cursor.
        --  Useful when your language has ways of declaring types without an actual implementation.
        map_lsp("gri", picker.lsp_implementations, "[G]oto [I]mplementation")

        -- Jump to the type of the word under your cursor.
        --  Useful when you're not sure what type a variable is and you want to see
        --  the definition of its *type*, not where it was *defined*.
        map_lsp("gD", picker.lsp_type_definitions, "Type [D]efinition")

        -- Fuzzy find all the symbols in your current document.
        --  Symbols are things like variables, functions, types, etc.
        map_lsp("gs", picker.lsp_symbols, "Document [S]ymbols")

        -- Fuzzy find all the symbols in your current workspace.
        --  Similar to document symbols, except searches over your entire project.
        map_lsp("gws", picker.lsp_workspace_symbols, "[W]orkspace [S]ymbols")

        map_lsp("gD", picker.diagnostics_buffer, "Diagnostics")

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
local load_lsps = function()
    for name, type in vim.fs.dir(vim.fn.stdpath("config") .. "/lsp") do
        if type ~= "file" then goto continue end
        name = vim.fs.basename(name):gsub(".lua", "")
        if name == "nixd" and vim.fn.has("win32") then goto continue end
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

map("n", "<leader>zig", "<Cmd>LspRestart<CR>", { desc = "Restart LSP" })
