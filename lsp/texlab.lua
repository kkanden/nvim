if vim.fn.has("win32") then
    local executable = "sumatrapdf"
    local args = {
        "-reuse-instance",
        "%p",
        "-forward-search",
        "%f",
        "%l",
    }
else
    local executable = "okular"
    local args = { "--unique", "file:%p#src:%l%f" }
end

return {
    cmd = { "texlab" },
    filetypes = { "tex", "plaintex", "bib" },
    settings = {
        texlab = {
            rootDirectory = nil,
            build = {
                executable = "latexmk",
                args = {
                    "-pdf",
                    "-interaction=nonstopmode",
                    "-synctex=1",
                    "%f",
                },
                onSave = true,
                forwardSearchAfter = true,
            },
            forwardSearch = {
                executable = executable,
                args = args,
            },
            chktex = {
                onOpenAndSave = false,
                onEdit = false,
            },
            diagnosticsDelay = 300,
            formatterLineLength = 80,
        },
    },
}
