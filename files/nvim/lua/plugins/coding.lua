return {
    { "ruifm/gitlinker.nvim" },
    {
        "folke/todo-comments.nvim",
        lazy = true,
        cmd = { "TodoTrouble", "TodoTelescope" },
        event = { "BufReadPost", "BufNewFile" },
    },
    {
        "danymat/neogen",
        event = "BufEnter",
    },
    {
        "m-demare/attempt.nvim",
        lazy = true,
        dependencies = {
            { "nvim-lua/plenary.nvim" },
        },
    },
    {
        "ThePrimeagen/git-worktree.nvim",
        event = "VeryLazy",
        opts = {},
    },
    {
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        opts = {},
    },
    {
        "echasnovski/mini.trailspace",
        main = "mini.trailspace",
        event = "BufEnter",
        opts = {},
    },
    {
        "Wansmer/treesj",
        keys = { "<space>m" },
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        opts = {},
    },
    {
        "ray-x/lsp_signature.nvim",
        event = "BufRead",
        opts = {},
    },
    {
        "folke/trouble.nvim",
        cmd = { "TroubleToggle", "Trouble" },
        opts = {
            use_diagnostic_signs = true,
        },
    },
    {
        "monaqa/dial.nvim",
        keys = {
            {
                "<C-a>",
                function()
                    return require("dial.map").inc_normal()
                end,
                expr = true,
                desc = "Increment",
            },
            {
                "<C-x>",
                function()
                    return require("dial.map").dec_normal()
                end,
                expr = true,
                desc = "Decrement",
            },
        },
        config = function()
            local augend = require("dial.augend")
            require("dial.config").augends:register_group({
                default = {
                    augend.integer.alias.decimal,
                    augend.integer.alias.hex,
                    augend.date.alias["%Y/%m/%d"],
                    augend.constant.alias.bool,
                    augend.semver.alias.semver,
                    augend.constant.new({ elements = { "let", "const" } }),
                },
            })
        end,
    },
}
