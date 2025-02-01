local augroup = require("kanden.lib.nvim_api").augroup
local map = require("kanden.lib.nvim_api").map

-- This is where you enable features that only work
-- if there is a language server active in the file
vim.api.nvim_create_autocmd("LspAttach", {
    group = augroup("lsp_attach"),
    -- LSP KEYBINDS
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if not client then return end

        local map = function(keys, func, desc, mode)
            mode = mode or "n"
            map(mode, keys, func, { buffer = args.buf, desc = "LSP: " .. desc })
        end
        -- Jump to the definition of the word under your cursor.
        --  This is where a variable was first declared, or where a function is defined, etc.
        --  To jump back, press <C-t>.
        map(
            "gd",
            require("telescope.builtin").lsp_definitions,
            "[G]oto [D]efinition"
        )

        -- Find references for the word under your cursor.
        map(
            "gr",
            require("telescope.builtin").lsp_references,
            "[G]oto [R]eferences"
        )

        -- Jump to the implementation of the word under your cursor.
        --  Useful when your language has ways of declaring types without an actual implementation.
        map(
            "gI",
            require("telescope.builtin").lsp_implementations,
            "[G]oto [I]mplementation"
        )

        -- Jump to the type of the word under your cursor.
        --  Useful when you're not sure what type a variable is and you want to see
        --  the definition of its *type*, not where it was *defined*.
        map(
            "<leader>D",
            require("telescope.builtin").lsp_type_definitions,
            "Type [D]efinition"
        )

        -- Fuzzy find all the symbols in your current document.
        --  Symbols are things like variables, functions, types, etc.
        map(
            "<leader>ds",
            require("telescope.builtin").lsp_document_symbols,
            "[D]ocument [S]ymbols"
        )

        -- Fuzzy find all the symbols in your current workspace.
        --  Similar to document symbols, except searches over your entire project.
        map(
            "<leader>ws",
            require("telescope.builtin").lsp_dynamic_workspace_symbols,
            "[W]orkspace [S]ymbols"
        )

        -- Rename the variable under your cursor.
        --  Most Language Servers support renaming across files, etc.
        map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

        -- Execute a code action, usually your cursor needs to be on top of an error
        -- or a suggestion from your LSP for this to activate.
        map(
            "<leader>ca",
            vim.lsp.buf.code_action,
            "[C]ode [A]ction",
            { "n", "x" }
        )

        -- Opens a popup that displays documentation about the word under cursor
        map("K", vim.lsp.buf.hover, "Hover Documentation")

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

local servers = {
    lua_ls = {},
    r_language_server = {},
    basedpyright = {},
    ltex = {},
    rust_analyzer = {
        filetypes = { "rust" },
        root_dir = require("lspconfig.util").root_pattern("Cargo.toml"),
        settings = {
            ["rust-analyzer"] = {
                cargo = {
                    allFeatures = true,
                },
            },
        },
    },
}

-- Setup mason
require("mason").setup({
    PATH = "prepend",
})

local ensure_installed = vim.tbl_keys(servers or {})
vim.list_extend(ensure_installed, {
    "stylua",
    "mypy",
    "black",
})
require("mason-tool-installer").setup({
    ensure_installed = ensure_installed,
})

require("mason-lspconfig").setup({
    handlers = {
        function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for ts_ls)
            server.capabilities = require("blink.cmp").get_lsp_capabilities()
            require("lspconfig")[server_name].setup(server)
        end,
    },
})

-- stylua: ignore
vim.g.LanguageClient_serverCommands = { r = { "R", "--slave", "-e", "languageserver::run()" } }
