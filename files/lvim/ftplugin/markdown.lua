local formatters = require("lvim.lsp.null-ls.formatters")
local linters = require("lvim.lsp.null-ls.linters")

linters.setup {
    { command = "markdownlint", filetypes = { "markdown" } },
}
formatters.setup {
    { command = "prettier", filetypes = { "markdown" } },
}
