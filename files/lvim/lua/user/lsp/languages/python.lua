local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
    {
        command = "black",
        extra_args = { "--line-length", "100" },
        filetypes = { "python" }
    },
}
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
    { command = "flake8", filetypes = { "python" } },
}

-- require('lspconfig').ruff_lsp.setup({
--     on_attach = function(client, bufnr)
--       -- Disable hover in favor of Pyright
--       client.resolved_capabilities.hover = false
--     end
--     -- on_init = require("lvim.lsp").common_on_init,
--     -- capabilities = require("lvim.lsp").common_capabilities(),
--     init_options = {
--         settings = {
--             -- Any extra CLI arguments for `ruff` go here.
--             args = {},
--         }
--     }
-- })

vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })

local lsp_manager = require "lvim.lsp.manager"
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
