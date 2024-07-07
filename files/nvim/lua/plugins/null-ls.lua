return {
    {
        "nvimtools/none-ls.nvim",
        event = "VeryLazy",
        config = function()
            local null_ls = require("null-ls")

            null_ls.setup({
                border = "rounded",
                sources = {
                    -- Lua
                    null_ls.builtins.formatting.stylua,
                    -- Go
                    null_ls.builtins.formatting.gofumpt,
                    null_ls.builtins.formatting.goimports,
                    null_ls.builtins.formatting.golines.with({ extra_args = { "--max-len", "120" } }),
                    null_ls.builtins.diagnostics.golangci_lint,
                    -- Python
                    null_ls.builtins.formatting.black.with({ extra_args = { "--line-length", "100" } }),
                    null_ls.builtins.formatting.isort.with({ extra_args = { "--line-length", "100" } }),
                    -- Markdown
                    null_ls.builtins.formatting.prettier.with({ filetypes = { "md" } }),
                    null_ls.builtins.formatting.markdownlint.with({ extra_args = { "-r", "~MD013" } }),
                    -- Shell
                    null_ls.builtins.formatting.shfmt.with({ filetypes = { "sh", "zsh", "bash" } }),
                    -- SQL
                    null_ls.builtins.formatting.sqlfmt,
                    -- Yaml
                    null_ls.builtins.diagnostics.yamllint,
                    -- Ansible
                    null_ls.builtins.diagnostics.ansiblelint,
                    -- JavaScript
                    null_ls.builtins.formatting.prettier.with({ filetypes = { "js" } }),
                },
            })
        end,
    },
    {
        "jay-babu/mason-null-ls.nvim",
        event = "VeryLazy",
        opts = {
            automatic_installation = false,
            ensure_installed = {
                -- Linters
                "ansiblelint",
                "golangci_lint",
                "markdownlint",
                "shellcheck",
                "yamllint",
                "pylint",
                "flake8",
                -- Formatters
                "stylua",
                "black",
                "isort",
                "gofumpt",
                "goimports",
                "prettier",
                "shfmt",
                "sqlfmt",
                "golines",
                "yamlfmt",
            },
        },
        dependencies = {
            "williamboman/mason.nvim",
            "nvimtools/none-ls.nvim",
        },
    },
}
