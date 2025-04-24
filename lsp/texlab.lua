return {
    cmd = { "texlab" },
    filetypes = { "tex", "plaintex", "bib" },
    settings = {
        texlab = {
            rootDirectory = nil,
            chktex = {
                onOpenAndSave = false,
                onEdit = false,
            },
            diagnosticsDelay = 300,
            formatterLineLength = 80,
        },
    },
}
