return {
    cmd = { "ansible-language-server", "--stdio" },
    root_markers = { "ansible.cfg", ".ansible-lint" },
    filetypes = { "yaml.ansible" },
    settings = {
        ansible = {
            python = {
                interpreterPath = "python",
            },
            ansible = {
                path = "ansible",
            },
            executionEnvironment = {
                enabled = false,
            },
            validation = {
                enabled = true,
                lint = {
                    enabled = true,
                    path = "ansible-lint",
                },
            },
        },
    },
}
