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

require("mason-tool-installer").setup({
    ensure_installed = ensure_installed,
})
