lvim.lsp.automatic_servers_installation = false
lvim.lsp.installer.setup.ensure_installed = {
    "ansiblels",
    "bashls",
    "clangd",
    "docker_compose_language_service",
    "dockerls",
    "golangci_lint_ls",
    "gopls",
    "helm_ls",
    "jsonls",
    "lua_ls",
    "pyright",
    "ruff_lsp",
    "sqlls",
    "vimls",
    "yamlls",
}

local status_ok, mason_null_ls = pcall(require, "mason-null-ls")
if not status_ok then
    return
end

mason_null_ls.setup({
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
        -- Formatters
        "black",
        "isort",
        "gofumpt",
        "goimports",
        "markdown_toc",
        "prettier",
        "shfmt",
        "sqlfmt",
        "golines",
    }
})
