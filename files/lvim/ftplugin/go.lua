local formatters = require "lvim.lsp.null-ls.formatters"
local lsp_manager = require "lvim.lsp.manager"

formatters.setup {
    { command = "goimports", filetypes = { "go" } },
    { command = "gofumpt",   filetypes = { "go" } },
}

vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "gopls" })
lsp_manager.setup("gopls", {
    on_attach = function(client, bufnr)
        require("lvim.lsp").common_on_attach(client, bufnr)
        require("lsp_signature").on_attach(
            { bind = true, handler_opts = { border = "rounded" } },
            bufnr
        )
        local _, _ = pcall(vim.lsp.codelens.refresh)
    end,
    on_init = require("lvim.lsp").common_on_init,
    capabilities = require("lvim.lsp").common_capabilities(),
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
        },
    },
})
lsp_manager.setup("golangci_lint_ls", {
    on_init = require("lvim.lsp").common_on_init,
    capabilities = require("lvim.lsp").common_capabilities(),
})

local status_ok, gopher = pcall(require, "gopher")
if not status_ok then
    return
end

gopher.setup {
    commands = {
        go = "go",
        gomodifytags = "gomodifytags",
        gotests = "gotests",
        impl = "impl",
        iferr = "iferr",
    },
}

local dap_ok, dapgo = pcall(require, "dap-go")
if not dap_ok then
    return
end

dapgo.setup()

local mappings = {
    ["C"] = {
        name = "Go",
        i = { "<cmd>GoInstallDeps<Cr>", "Install Go Dependencies" },
        f = { "<cmd>GoMod tidy<cr>", "Tidy" },
        a = { "<cmd>GoTestAdd<Cr>", "Add Test" },
        A = { "<cmd>GoTestsAll<Cr>", "Add All Tests" },
        e = { "<cmd>GoTestsExp<Cr>", "Add Exported Tests" },
        g = { "<cmd>GoGenerate<Cr>", "Go Generate" },
        G = { "<cmd>GoGenerate %<Cr>", "Go Generate File" },
        c = { "<cmd>GoCmt<Cr>", "Generate Comment" },
        t = { "<cmd>lua require('dap-go').debug_test()<cr>", "Debug Test" },
    },
}
for k, v in pairs(mappings) do
    lvim.builtin.which_key.mappings[k] = v
end
