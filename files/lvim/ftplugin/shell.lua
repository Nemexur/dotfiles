local formatters = require "lvim.lsp.null-ls.formatters"
local lsp_manager = require "lvim.lsp.manager"

formatters.setup {
    { command = "shfmt", filetypes = { "sh", "zsh", "bash" } },
}

vim.filetype.add {
    extension = {
        zsh = "zsh",
    },
}

vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "bashls" })
lsp_manager.setup("bashls", {
    filetypes = { "sh", "zsh", "bash" },
    on_init = require("lvim.lsp").common_on_init,
    capabilities = require("lvim.lsp").common_capabilities(),
})
