local null_ls_ok, null_ls = pcall(require, "null-ls")
if not null_ls_ok then
    return
end

null_ls.setup({
    border = "rounded",
    sources = {
        -- Lua
        null_ls.builtins.formatting.stylua,
        -- Go
        null_ls.builtins.formatting.gofumpt,
        null_ls.builtins.formatting.goimports,
        null_ls.builtins.formatting.golines,
        null_ls.builtins.diagnostics.golangci_lint,
        -- Python
        null_ls.builtins.formatting.black.with({ extra_args = { "--line-length", "100" } }),
        null_ls.builtins.formatting.isort.with({ extra_args = { "--line-length", "100" } }),
        -- Markdown
        null_ls.builtins.formatting.markdown_toc,
        null_ls.builtins.formatting.prettier.with({ filetypes = { "md" } }),
        null_ls.builtins.formatting.markdownlint.with({ extra_args = { "-r", "~MD013" } }),
        -- Shell
        null_ls.builtins.formatting.shfmt.with({ filetypes = { "sh", "zsh", "bash" } }),
        null_ls.builtins.diagnostics.shellcheck.with({ filetypes = { "sh", "zsh", "bash" } }),
        -- SQL
        null_ls.builtins.formatting.sqlfmt,
        -- Json
        null_ls.builtins.diagnostics.jsonlint,
        -- Yaml
        null_ls.builtins.diagnostics.yamllint,
        -- Ansible
        null_ls.builtins.diagnostics.ansiblelint,
        -- Editorconfig
        null_ls.builtins.diagnostics.editorconfig_checker,
    },
})

local mason_null_ls_ok, mason_null_ls = pcall(require, "mason-null-ls")
if not mason_null_ls_ok then
    return
end

mason_null_ls.setup({
    automatic_installation = false,
    ensure_installed = {
        -- Linters
        "ansiblelint",
        "editorconfig_checker",
        "golangci_lint",
        "jsonlint",
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
        "markdown_toc",
        "prettier",
        "shfmt",
        "sqlfmt",
        "golines",
    },
})
