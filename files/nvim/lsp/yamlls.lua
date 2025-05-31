return {
    cmd = { "yaml-language-server", "--stdio" },
    filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab" },
    root_markers = { ".git" },
    settings = {
        redhat = { telemetry = { enabled = false } },
        yaml = {
            hover = true,
            completion = true,
            format = {
                enable = true,
            },
            editor = {
                tabSize = 2,
            },
        },
    },
}
