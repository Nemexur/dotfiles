local python_plugins = {
    {
        "jeetsukumaran/vim-pythonsense",
        ft = "python",
    },
}

for _, v in ipairs(python_plugins) do
    table.insert(lvim.plugins, v)
end
