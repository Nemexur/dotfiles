return {
    { "chaoren/vim-wordmotion" },
    {
        "numToStr/Comment.nvim",
        lazy = true,
        opts = {},
        keys = { { "gc", mode = { "n", "v" } }, { "gb", mode = { "n", "v" } } },
        event = "User FileOpened",
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        opts = {
            window = {
                border = "single", -- none, single, double, shadow
                position = "bottom", -- bottom, top
                margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
                padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
                winblend = 0,
            },
            layout = {
                height = { min = 4, max = 25 }, -- min and max height of the columns
                width = { min = 20, max = 50 }, -- min and max width of the columns
                spacing = 3, -- spacing between columns
                align = "left", -- align columns left, center or right
            },
        },
    },
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        event = "BufRead",
        opts = {},
        dependencies = {
            { "nvim-lua/plenary.nvim" },
        },
    },
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
                "r",
                mode = { "o", "x" },
                function()
                    require("flash").treesitter_search()
                end,
                desc = "Flash Treesitter Search",
            },
        },
    },
    {
        "cshuaimin/ssr.nvim",
        event = "BufRead",
        opts = {},
    },
    {
        "smjonas/inc-rename.nvim",
        cmd = "IncRename",
        config = true,
    },
    {
        "windwp/nvim-spectre",
        event = "BufRead",
        opts = {},
    },
    {
        "gbprod/yanky.nvim",
        lazy = true,
        opts = {},
    },
    {
        "gbprod/substitute.nvim",
        lazy = true,
        config = function()
            require("substitute").setup({
                on_substitute = require("yanky.integration").substitute(),
            })
        end,
    },
    {
        "andymass/vim-matchup",
        lazy = true,
        config = function()
            vim.g.matchup_matchparen_offscreen = { method = "popup" }
        end,
    },
}
