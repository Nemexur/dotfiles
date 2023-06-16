local go_plugins = {
    {
        "leoluz/nvim-dap-go",
        ft = "go",
    },
    {
        "olexsmir/gopher.nvim",
        ft = "go",
    },
}

for _, v in ipairs(go_plugins) do
    table.insert(lvim.plugins, v)
end
