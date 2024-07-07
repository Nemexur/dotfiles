local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_ok then
    return
end

lspconfig.pyright.setup({
    single_file_support = true,
    settings = {
        python = {
            analysis = {
                autoSearchPaths = true,
                autoImportCompletions = false,
                diagnosticMode = "openFilesOnly", -- openFilesOnly, workspace
                typeCheckingMode = "basic", -- off, basic, strict
                useLibraryCodeForTypes = true,
            },
        },
    },
})
