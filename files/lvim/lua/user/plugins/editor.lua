local M = {}

M.plugins = {
    { "chaoren/vim-wordmotion" },
    {
        "mbbill/undotree",
        event = "VeryLazy",
    },
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        opts = {
            label = {
                rainbow = {
                    enabled = true,
                },
            },
            highlight = {
                priority = 9000,
            },
            modes = {
                char = {
                    autohide = true,
                    highlight = { backdrop = false },
                },
            },
        },
        keys = {
            {
                "<C-f>",
                mode = { "n", "x", "o" },
                function()
                    require("flash").jump()
                end,
                desc = "Flash",
            },
            {
                "R",
                mode = { "o", "x" },
                function()
                    require("flash").treesitter_search()
                end,
                desc = "Flash Treesitter Search",
            },
        },
    },
    {
        "windwp/nvim-spectre",
        event = "BufRead",
        opts = {},
    },
    {
        "gbprod/yanky.nvim",
        opts = {},
    },
    {
        "andrewferrier/wrapping.nvim",
        opts = {},
    },
    {
        "gbprod/substitute.nvim",
        event = "BufEnter",
        opts = {
            on_substitute = require("yanky.integration").substitute(),
        },
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
        opts = {
            show_numbers = true,    -- Enable 'number' for the window while peeking
            show_cursorline = true, -- Enable 'cursorline' for the window while peeking
        },
    },
}

return M
