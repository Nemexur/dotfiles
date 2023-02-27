require "user.lsp.languages.ansible"
require "user.lsp.languages.go"
require "user.lsp.languages.python"
require "user.lsp.languages.shell"

local linters = require("lvim.lsp.null-ls.linters")
linters.setup {
    { command = "markdownlint", filetypes = { "markdown" } },
}
