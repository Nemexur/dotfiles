local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_ok then
    return
end

lspconfig.gopls.setup({
    settings = {
        gopls = {
            usePlaceholders = true,
            gofumpt = true,
            analyses = {
                unusedparams = true,
            },
            staticcheck = true,
            codelenses = {
                generate = false,
                gc_details = true,
                test = true,
                tidy = true,
            },
            hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
            },
        },
    },
})

local wk_ok, wk = pcall(require, "which-key")
if not wk_ok then
    return
end

wk.add({
    { "<leader>c", group = "Go" },
    { "<leader>ci", "<cmd>GoInstallDeps<cr>", desc = "Install Go Dependencies", mode = "n" },
    { "<leader>cf", "<cmd>GoMod tidy<cr>", desc = "Tidy", mode = "n" },
    { "<leader>ca", "<cmd>GoTestAdd<cr>", desc = "Add Test", mode = "n" },
    { "<leader>cA", "<cmd>GoTestsAll<cr>", desc = "Add All Tests", mode = "n" },
    { "<leader>cE", "<cmd>GoTestsExp<cr>", desc = "Add Exported Tests", mode = "n" },
    { "<leader>cg", "<cmd>GoGenerate<cr>", desc = "Go Generate", mode = "n" },
    { "<leader>cG", "<cmd>GoGenerate %<cr>", desc = "Go Generate File", mode = "n" },
    { "<leader>cc", "<cmd>GoCmt<cr>", desc = "Generate Comment", mode = "n" },
    { "<leader>ce", "<cmd>GoIfErr<cr>", desc = "Generate if err", mode = "n" },
    { "<leader>cd", "<cmd>GoCmt<cr>", desc = "Generate doc", mode = "n" },
    { "<leader>ct", group = "Struct Tags" },
    { "<leader>ctj", "<cmd>GoTagAdd json<cr>", desc = "JSON", mode = "n" },
    { "<leader>cty", "<cmd>GoTagAdd yaml<cr>", desc = "YAML", mode = "n" },
})
