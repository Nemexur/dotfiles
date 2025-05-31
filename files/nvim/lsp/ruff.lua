return {
    cmd = { "ruff", "server" },
    filetypes = { "python" },
    root_markers = { "pyproject.toml", "ruff.toml", ".ruff.toml", ".git" },
    init_options = {
        settings = {
            configurationPreference = "filesystemFirst",
            lineLength = 100,
            organizeImports = true,
            showSyntaxErrors = true,
            codeAction = { fixViolation = { enable = false } },
            format = {
                preview = true,
                ["quote-style"] = "double",
                ["indent-style"] = "space",
                ["indent-styleskip-magic-trailing-comma"] = true,
                ["line-ending"] = "auto",
            },
        },
    },
}
