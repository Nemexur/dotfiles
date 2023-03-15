local utils = require("yanky.utils")
local mapping = require("yanky.telescope.mapping")
local telescope = require("telescope")

telescope.load_extension("yank_history")

require("yanky").setup({
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
                    r = mapping.set_register(utils.get_default_register())
                },
            }
        }
    }
})
