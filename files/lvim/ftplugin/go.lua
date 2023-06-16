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
    ["c"] = {
        name = "Go",
        i = { "<cmd>GoInstallDeps<cr>", "Install Go Dependencies" },
        f = { "<cmd>GoMod tidy<cr>", "Tidy" },
        a = { "<cmd>GoTestAdd<cr>", "Add Test" },
        A = { "<cmd>GoTestsAll<cr>", "Add All Tests" },
        E = { "<cmd>GoTestsExp<cr>", "Add Exported Tests" },
        g = { "<cmd>GoGenerate<cr>", "Go Generate" },
        G = { "<cmd>GoGenerate %<cr>", "Go Generate File" },
        c = { "<cmd>GoCmt<cr>", "Generate Comment" },
        T = { "<cmd>lua require('dap-go').debug_test()<cr>", "Debug Test" },
        e = { "<cmd>GoIfErr<cr>", "Generate if err" },
        d = { "<cmd>GoCmt<cr>", "Generate doc" },
        t = {
            name = "Struct tags",
            j = { "<cmd>GoTagAdd json<cr>", "json" },
            y = { "<cmd>GoTagAdd yaml<cr>", "yaml" },
        },
    },
}
for k, v in pairs(mappings) do
    lvim.builtin.which_key.mappings[k] = v
end
