local function add_plugins(m)
    for _, v in ipairs(m.plugins) do
        table.insert(lvim.plugins, v)
    end
end

add_plugins(require("user.plugins.ui"))
add_plugins(require("user.plugins.coding"))
add_plugins(require("user.plugins.editor"))
add_plugins(require("user.plugins.extras"))
add_plugins(require("user.plugins.go"))
add_plugins(require("user.plugins.python"))
add_plugins(require("user.plugins.ansible"))
