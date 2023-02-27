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
