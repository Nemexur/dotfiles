local M = {}

M.plugins = {
    { "lervag/vimtex" },
    { "jay-babu/mason-null-ls.nvim" },
    {
        "folke/persistence.nvim",
        event = "BufReadPre", -- this will only start session saving when an actual file was opened
        opts = {
            dir = vim.fn.expand(vim.fn.stdpath "config" .. "/session/"),
            options = { "buffers", "curdir", "tabpages", "winsize" },
        },
    },
}

return M
