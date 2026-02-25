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
                printWidth = 100,
            },
            editor = {
                tabSize = 2,
                formatOnType = true,
            },
            schemas = {
                ["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = "*.gitlab-ci*.{yml,yaml}",
                ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "*docker-compose*.{yml,yaml}",
                ["https://json.schemastore.org/pre-commit-config.json"] = "*.pre-commit-config.{yml,yaml}",
            }
        },
    },
}
