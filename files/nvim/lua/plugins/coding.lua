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
}
