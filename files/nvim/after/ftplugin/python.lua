local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_ok then
    return
end

lspconfig.pyright.setup({
    single_file_support = true,
    settings = {
        pyright = {
            disableLanguageServices = false,
            disableOrganizeImports = false,
        },
        python = {
            analysis = {
                autoImportCompletions = true,
                autoSearchPaths = true,
                diagnosticMode = "workspace", -- openFilesOnly, workspace
                typeCheckingMode = "basic",   -- off, basic, strict
                useLibraryCodeForTypes = true,
            },
        },
    },
})

lspconfig.ruff_lsp.setup({})
