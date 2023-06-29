local M = {}

M.plugins = {
    { "michaeljsmith/vim-indent-object" },
    { "chaoren/vim-wordmotion" },
    {
        "mbbill/undotree",
        event = "VeryLazy",
    },
    {
        "m4xshen/hardtime.nvim",
        event = "VeryLazy",
        opts = {
            disable_mouse = false,
            disabled_keys = {},
        },
    },
    {
        "phaazon/hop.nvim",
        branch = "v2",
        opts = {
            keys = "etovxqpdygfblzhckisuran",
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
        "ThePrimeagen/harpoon",
        event = "VeryLazy",
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
