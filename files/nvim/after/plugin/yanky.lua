local yanky_ok, yanky = pcall(require, "yanky")
if not yanky_ok then
    return
end

local utils_ok, utils = pcall(require, "yanky.utils")
if not utils_ok then
    return
end

local mapping_ok, mapping = pcall(require, "yanky.telescope.mapping")
if not mapping_ok then
    return
end

yanky.setup({
    picker = {
        telescope = {
            mappings = {
                default = mapping.put("p"),
                i = {
                    ["<c-p>"] = mapping.put("p"),
                    ["<c-k>"] = mapping.put("P"),
                    ["<c-x>"] = mapping.delete(),
                    ["<c-r>"] = mapping.set_register(utils.get_default_register()),
                },
                n = {
                    p = mapping.put("p"),
                    P = mapping.put("P"),
                    d = mapping.delete(),
                    r = mapping.set_register(utils.get_default_register()),
                },
            },
        },
    },
})
