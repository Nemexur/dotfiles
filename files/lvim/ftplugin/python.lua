local formatters = require "lvim.lsp.null-ls.formatters"
local linters = require "lvim.lsp.null-ls.linters"
local lsp_manager = require "lvim.lsp.manager"

formatters.setup {
    {
        command = "black",
        extra_args = { "--line-length", "100" },
        filetypes = { "python" }
    },
}
linters.setup {
    { command = "flake8", filetypes = { "python" } },
}

vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "ruff_lsp" })
lsp_manager.setup("ruff_lsp", {
    on_attach = function(client, bufnr)
        require("lvim.lsp").common_on_attach(client, bufnr)
        require("lsp_signature").on_attach(
            { bind = true, handler_opts = { border = "rounded" } },
            bufnr
        )
        local _, _ = pcall(vim.lsp.codelens.refresh)
        client.server_capabilities.hoverProvider = false
    end,
    on_init = require("lvim.lsp").common_on_init,
    capabilities = require("lvim.lsp").common_capabilities(),
})

vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
lsp_manager.setup("pyright", {
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
})
