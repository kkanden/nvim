local ensure_installed = {
    "lua-language-server",
    "r-languageserver",
    "basedpyright",
    "ltex-ls",
    "texlab",
    "rust-analyzer",
    "json-lsp",
    "yaml-language-server",
    "css-lsp",
}
if vim.fn.has("linux") + vim.fn.has("wsl") + vim.fn.has("mac") >= 1 then
    table.insert(ensure_installed, "nil_ls")
end

require("mason-tool-installer").setup({
    ensure_installed = ensure_installed,
})

-- -- stylua: ignore
-- vim.g.LanguageClient_serverCommands = { r '= { "R", "--slave", "-e", "languageserver::run()" } }
