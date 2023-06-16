local extras_plugins = {
    { "lervag/vimtex" },
    { "jay-babu/mason-null-ls.nvim" },
    {
        "folke/persistence.nvim",
        event = "BufReadPre", -- this will only start session saving when an actual file was opened
        config = function()
            require("persistence").setup {
                dir = vim.fn.expand(vim.fn.stdpath "config" .. "/session/"),
                options = { "buffers", "curdir", "tabpages", "winsize" },
            }
        end,
    },
}

for _, v in ipairs(extras_plugins) do
    table.insert(lvim.plugins, v)
end
