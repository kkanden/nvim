local augroup = require("kanden.lib").augroup
local map = require("kanden.lib").map
local picker = Snacks.picker

-- This is where you enable features that only work
-- if there is a language server active in the file
vim.api.nvim_create_autocmd("LspAttach", {
    group = augroup("lsp_attach"),
    callback = function(args)
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

        local map = function(keys, func, desc, mode)
            mode = mode or "n"
            map(mode, keys, func, { buffer = args.buf, desc = "LSP: " .. desc })
        end
        -- Jump to the definition of the word under your cursor.
        --  This is where a variable was first declared, or where a function is defined, etc.
        --  To jump back, press <C-t>.
        map("gd", picker.lsp_definitions, "[G]oto [D]efinition")

        -- Find references for the word under your cursor.
        map("grr", picker.lsp_references, "[G]oto [R]eferences")

        -- Jump to the implementation of the word under your cursor.
        --  Useful when your language has ways of declaring types without an actual implementation.
        map("gri", picker.lsp_implementations, "[G]oto [I]mplementation")

        -- Jump to the type of the word under your cursor.
        --  Useful when you're not sure what type a variable is and you want to see
        --  the definition of its *type*, not where it was *defined*.
        -- map("<leader>D", picker.lsp_type_definitions, "Type [D]efinition")

        -- Fuzzy find all the symbols in your current document.
        --  Symbols are things like variables, functions, types, etc.
        -- map("<leader>ds", picker.lsp_symbols, "[D]ocument [S]ymbols")

        -- Fuzzy find all the symbols in your current workspace.
        --  Similar to document symbols, except searches over your entire project.
        -- map("<leader>ws", picker.lsp_workspace_symbols, "[W]orkspace [S]ymbols")

        -- WARN: This is not Goto Definition, this is Goto Declaration.
        --  For example, in C this would take you to the header.
        map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

        -- Move to next/prev diagnostic
        map("g]", function()
            local min_severity = vim.bo.filetype == "r"
                    and vim.diagnostic.severity.ERROR
                or vim.diagnostic.severity.WARN
            vim.diagnostic.goto_next({
                severity = min_severity,
            })
        end, "Go to next diagnostic")

        map("g[", function()
            local min_severity = vim.bo.filetype == "r"
                    and vim.diagnostic.severity.ERROR
                or vim.diagnostic.severity.WARN
            vim.diagnostic.goto_prev({
                severity = min_severity,
            })
        end, "Go to previous diagnostic")
    end,
})

-- Enable LSP's
for name, type in vim.fs.dir(vim.fn.stdpath("config") .. "/lsp") do
    if type ~= "file" then goto continue end
    name = vim.fs.basename(name):gsub(".lua", "")
    if (name == "nil_ls" and vim.fn.has("win32") == 1) or name == "init" then
        goto continue
    end -- skip nil if on windows
    vim.lsp.enable(name)
    ::continue::
end
