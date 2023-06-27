local editor_plugins = {
    { "michaeljsmith/vim-indent-object" },
    { "chaoren/vim-wordmotion" },
    {
        "mbbill/undotree",
        event = "VeryLazy",
    },
    {
        "phaazon/hop.nvim",
        branch = "v2",
        config = function()
            require("hop").setup({
                keys = "etovxqpdygfblzhckisuran",
            })
        end
    },
    {
        "windwp/nvim-spectre",
        event = "BufRead",
        config = function()
            require("spectre").setup()
        end,
    },
    {
        "gbprod/yanky.nvim",
        config = function()
            require("yanky").setup()
        end,
    },
    {
        "ThePrimeagen/harpoon",
        event = "VeryLazy",
        config = function()
            require("harpoon").setup()
        end
    },
    {
        "gbprod/substitute.nvim",
        event = "BufEnter",
        config = function()
            require("substitute").setup({
                on_substitute = require("yanky.integration").substitute(),
            })
        end,
    },
    {
        "andymass/vim-matchup",
        config = function()
            vim.g.matchup_matchparen_offscreen = { method = "popup" }
        end,
    },
    {
        "nacro90/numb.nvim",
        event = "BufRead",
        config = function()
            require("numb").setup {
                show_numbers = true,    -- Enable 'number' for the window while peeking
                show_cursorline = true, -- Enable 'cursorline' for the window while peeking
            }
        end,
    },
    {
        "andrewferrier/wrapping.nvim",
        config = function()
            require("wrapping").setup()
        end
    },
}

for _, v in ipairs(editor_plugins) do
    table.insert(lvim.plugins, v)
end
