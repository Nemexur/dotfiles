local ansible_plugins = {
    {
        "pearofducks/ansible-vim",
        ft = "yaml.ansible",
    },
}

for _, v in ipairs(ansible_plugins) do
    table.insert(lvim.plugins, v)
end
