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
        opts = {},
        dependencies = { "nvim-lua/plenary.nvim" },
    },
    {
        "folke/flash.nvim",
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
            {
                "<leader>fp",
                function()
                    require("telescope").extensions.yank_history.yank_history({})
                end,
                desc = "Open Yank History",
            },
            {
                "y",
                "<Plug>(YankyYank)",
                mode = { "n", "x" },
                desc = "Yank text",
            },
            {
                "p",
                "<Plug>(YankyPutAfter)",
                mode = { "n", "x" },
                desc = "Put yanked text after cursor",
            },
            {
                "P",
                "<Plug>(YankyPutBefore)",
                mode = { "n", "x" },
                desc = "Put yanked text before cursor",
            },
            {
                "gp",
                "<Plug>(YankyGPutAfter)",
                mode = { "n", "x" },
                desc = "Put yanked text after selection",
            },
            {
                "gP",
                "<Plug>(YankyGPutBefore)",
                mode = { "n", "x" },
                desc = "Put yanked text before selection",
            },
            {
                "[y",
                "<Plug>(YankyCycleForward)",
                desc = "Cycle forward through yank history",
            },
            {
                "]y",
                "<Plug>(YankyCycleBackward)",
                desc = "Cycle backward through yank history",
            },
            {
                "]p",
                "<Plug>(YankyPutIndentAfterLinewise)",
                desc = "Put indented after cursor (linewise)",
            },
            {
                "[p",
                "<Plug>(YankyPutIndentBeforeLinewise)",
                desc = "Put indented before cursor (linewise)",
            },
            {
                "]P",
                "<Plug>(YankyPutIndentAfterLinewise)",
                desc = "Put indented after cursor (linewise)",
            },
            {
                "[P",
                "<Plug>(YankyPutIndentBeforeLinewise)",
                desc = "Put indented before cursor (linewise)",
            },
            {
                ">p",
                "<Plug>(YankyPutIndentAfterShiftRight)",
                desc = "Put and indent right",
            },
            {
                "<p",
                "<Plug>(YankyPutIndentAfterShiftLeft)",
                desc = "Put and indent left",
            },
            {
                ">P",
                "<Plug>(YankyPutIndentBeforeShiftRight)",
                desc = "Put before and indent right",
            },
            {
                "<P",
                "<Plug>(YankyPutIndentBeforeShiftLeft)",
                desc = "Put before and indent left",
            },
            {
                "=p",
                "<Plug>(YankyPutAfterFilter)",
                desc = "Put after applying a filter",
            },
            {
                "=P",
                "<Plug>(YankyPutBeforeFilter)",
                desc = "Put before applying a filter",
            },
        },
        opts = {},
    },
    {
        "gbprod/substitute.nvim",
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
