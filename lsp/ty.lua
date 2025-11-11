return {
    cmd = { "ty", "server" },
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
        ty = {
            inlayHints = {
                callArgumentNames = false,
            },
            experimental = {
                rename = true,
                autoImport = true,
            },
        },
    },
}
