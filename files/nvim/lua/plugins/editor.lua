return {
    { "chaoren/vim-wordmotion", event = "VeryLazy" },
    {
        "numToStr/Comment.nvim",
        keys = {
            { "gc", mode = { "n", "v" } },
            { "gb", mode = { "n", "v" } },
        },
        opts = {},
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
        event = "VeryLazy",
        opts = {},
        dependencies = { "nvim-lua/plenary.nvim" },
    },
    {
        "folke/flash.nvim",
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
    },
    {
        "nvim-pack/nvim-spectre",
        opts = {},
    },
    {
        "cshuaimin/ssr.nvim",
        opts = {},
    },
    {
        "smjonas/inc-rename.nvim",
        cmd = "IncRename",
        config = true,
    },
    {
        "gbprod/yanky.nvim",
        keys = {
            { "p", mode = { "n", "x" } },
            { "P", mode = { "n", "x" } },
            { "gp", mode = { "n", "x" } },
            { "gP", mode = { "n", "x" } },
        },
        config = function()
            local yanky = require("yanky")
            local utils = require("yanky.utils")
            local mapping = require("yanky.telescope.mapping")

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
            vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
            vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
            vim.keymap.set({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)")
            vim.keymap.set({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)")
        end,
    },
    {
        "gbprod/substitute.nvim",
        keys = {
            {
                "s",
                mode = "v",
                function()
                    require("substitute").visual()
                end,
                desc = "Substitute visual",
            },
            {
                "X",
                mode = "v",
                function()
                    require("substitute.exchange").visual()
                end,
                desc = "Substitute exchange visual",
            },
        },
        config = function()
            require("substitute").setup({
                on_substitute = require("yanky.integration").substitute(),
            })
        end,
        dependencies = {
            "gbprod/yanky.nvim",
        },
    },
    {
        "andymass/vim-matchup",
        event = { "BufReadPost", "BufNewFile", "BufWritePre" },
        config = function()
            vim.g.matchup_matchparen_offscreen = { method = "popup" }
        end,
    },
}
