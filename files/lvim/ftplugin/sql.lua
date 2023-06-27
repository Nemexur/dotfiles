local formatters = require "lvim.lsp.null-ls.formatters"
local lsp_manager = require "lvim.lsp.manager"

formatters.setup {
    { command = "sqlfmt", filetypes = { "sql" } },
}

vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "sqlls" })
lsp_manager.setup("sqlls", {
    filetypes = { "sql" },
    on_attach = function(client, bufnr)
        require("lvim.lsp").common_on_attach(client, bufnr)
        require("lsp_signature").on_attach(
            { bind = true, handler_opts = { border = "rounded" } },
            bufnr
        )
    end,
    on_init = require("lvim.lsp").common_on_init,
    capabilities = require("lvim.lsp").common_capabilities(),
})
