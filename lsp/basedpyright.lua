return {
    cmd = { "basedpyright-langserver", "--stdio" },
    filetypes = { "python" },
    root_markers = {
        "pyproject.toml",
        "setup.py",
        "setup.cfg",
        "requirements.txt",
        "Pipfile",
        "pyrightconfig.json",
    },
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
