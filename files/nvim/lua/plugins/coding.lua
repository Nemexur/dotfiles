return {
    {
        "ruifm/gitlinker.nvim",
        event = "VeryLazy",
        opts = {
            mappings = nil,
        },
    },
    {
        "folke/todo-comments.nvim",
        event = "VeryLazy",
        cmd = { "TodoTrouble", "TodoTelescope" },
        opts = {},
    },
    {
        "danymat/neogen",
        event = "VeryLazy",
        opts = {
            snippet_engine = "luasnip",
            enabled = true,
            languages = {
                lua = {
                    template = {
                        annotation_convention = "emmylua",
                    },
                },
                python = {
                    template = {
                        annotation_convention = "numpydoc",
                    },
                },
                rust = {
                    template = {
                        annotation_convention = "rustdoc",
                    },
                },
            },
        },
    },
    {
        "ThePrimeagen/git-worktree.nvim",
        event = "VeryLazy",
        opts = {},
    },
    {
        "kylechui/nvim-surround",
        event = "VeryLazy",
        version = "*",
        opts = {},
    },
    {
        "Wansmer/treesj",
        keys = {
            {
                "<space>m",
                mode = { "n", "x", "o" },
                function()
                    require("treesj").toggle()
                end,
                desc = "Toggle Node",
            },
        },
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        opts = {},
    },
    {
        "ray-x/lsp_signature.nvim",
        event = "VeryLazy",
        opts = {},
    },
    {
        "folke/trouble.nvim",
        event = "VeryLazy",
        cmd = { "TroubleToggle", "Trouble" },
        opts = {
            use_diagnostic_signs = true,
        },
    },
    {
        "monaqa/dial.nvim",
        event = "VeryLazy",
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
