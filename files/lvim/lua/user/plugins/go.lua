local go_plugins = {
    { "leoluz/nvim-dap-go" },
    { "olexsmir/gopher.nvim" },
}

for _, v in ipairs(go_plugins) do
    table.insert(lvim.plugins, v)
end
