local extras_plugins = {
    {
        "folke/persistence.nvim",
        event = "BufReadPre",
        config = function()
            require("persistence").setup({
                opts = {
                    options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals" },
                },
            })
        end
    },
}

for _, v in ipairs(extras_plugins) do
    table.insert(lvim.plugins, v)
end
