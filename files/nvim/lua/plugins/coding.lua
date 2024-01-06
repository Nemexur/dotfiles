return {
    {
        "ruifm/gitlinker.nvim",
        opts = {
            mappings = nil,
        },
    },
    {
        "folke/todo-comments.nvim",
        event = "VeryLazy",
        opts = {},
    },
    {
        "danymat/neogen",
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
                go = {
                    template = {
                        annotation_convention = "godoc",
                    },
                },
            },
        },
        dependencies = { "nvim-treesitter/nvim-treesitter" },
    },
    {
        "ThePrimeagen/git-worktree.nvim",
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
        opts = {},
        dependencies = { "nvim-treesitter/nvim-treesitter" },
    },
    {
        "ray-x/lsp_signature.nvim",
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
                    return require("dial.map").manipulate("increment", "normal")
                end,
                desc = "Increment",
            },
            {
                "<C-x>",
                function()
                    return require("dial.map").manipulate("decrement", "normal")
                end,
                desc = "Decrement",
            },
            {
                "g<C-a>",
                function()
                    return require("dial.map").manipulate("increment", "gnormal")
                end,
                desc = "gIncrement",
            },
            {
                "g<C-x>",
                function()
                    return require("dial.map").manipulate("decrement", "gnormal")
                end,
                desc = "gDecrement",
            },
            {
                "<C-a>",
                function()
                    return require("dial.map").manipulate("increment", "visual")
                end,
                mode = { "v" },
                desc = "Increment",
            },
            {
                "<C-x>",
                function()
                    return require("dial.map").manipulate("decrement", "visual")
                end,
                mode = { "v" },
                desc = "Decrement",
            },
            {
                "g<C-a>",
                function()
                    return require("dial.map").manipulate("increment", "gvisual")
                end,
                mode = { "v" },
                desc = "gIncrement",
            },
            {
                "g<C-x>",
                function()
                    return require("dial.map").manipulate("decrement", "gvisual")
                end,
                mode = { "v" },
                desc = "gDecrement",
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
