return {
    cmd = { "R", "--slave", "-e", "languageserver::run()" },
    filetypes = { "r", "rmd" },
    root_markers = { ".Rprofile" },
    settings = {
        r = { lsp = { diagnostics = false } },
    },
}
