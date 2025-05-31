return {
    {
        "jay-babu/mason-null-ls.nvim",
        event = "VeryLazy",
        dependencies = { "williamboman/mason.nvim", "nvimtools/none-ls.nvim" },
        config = function()
            require("mason-null-ls").setup({
                automatic_installation = false,
                ensure_installed = {
                    -- Linters
                    "ansiblelint",
                    "golangci_lint",
                    "markdownlint",
                    "shellcheck",
                    "yamllint",
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
                handlers = {}
            })
            require("null-ls").setup({ border = "rounded" })
        end,
    },
}
