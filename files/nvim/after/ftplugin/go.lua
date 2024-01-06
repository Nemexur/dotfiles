local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_ok then
    return
end

lspconfig.gopls.setup({
    settings = {
        gopls = {
            usePlaceholders = false,
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

local gopher_ok, gopher = pcall(require, "gopher")
if not gopher_ok then
    return
end

gopher.setup({
    commands = {
        go = "go",
        gomodifytags = "gomodifytags",
        gotests = "gotests",
        impl = "impl",
        iferr = "iferr",
    },
})

local which_key_ok, which_key = pcall(require, "which-key")
if not which_key_ok then
    return
end

local opts = {
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true, -- use `nowait` when creating keymaps
}
local mappings = {
    c = {
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
which_key.register(mappings, opts)
