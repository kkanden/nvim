return {
    cmd = { "texlab" },
    filetypes = { "tex", "plaintex", "bib" },
    settings = {
        texlab = {
            rootDirectory = nil,
            forwardSearch = {
                executable = nil,
                args = {},
            },
            chktex = {
                onOpenAndSave = false,
                onEdit = false,
            },
            diagnosticsDelay = 300,
        },
    },
}
