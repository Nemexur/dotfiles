local formatters = require("lvim.lsp.null-ls.formatters")
local linters = require("lvim.lsp.null-ls.linters")

linters.setup {
    { name = "markdownlint", args = { "-r", "~MD013" }, filetypes = { "markdown" } },
}
formatters.setup {
    { name = "prettier", filetypes = { "markdown" } },
}
