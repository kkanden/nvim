return {
    cmd = { "basedpyright" },
    filetypes = { "python" },
    root_markers = { ".git/" },
    settings = {
        basedpyright = {
            analysis = {
                diagnosticSeverityOverrides = vim.json.decode(
                    table.concat(
                        vim.fn.readfile(
                            vim.fn.stdpath("config")
                                .. "/assets/pyrightconfig.json"
                        )
                    )
                ),
            },
        },
    },
}
