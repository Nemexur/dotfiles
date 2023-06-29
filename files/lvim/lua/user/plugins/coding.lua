local M = {}

M.plugins = {
    { "ruifm/gitlinker.nvim" },
    { "gpanders/editorconfig.nvim" },
    {
        "folke/todo-comments.nvim",
        cmd = { "TodoTrouble", "TodoTelescope" },
        event = { "BufReadPost", "BufNewFile" },
    },
    {
        "danymat/neogen",
        event = "BufEnter",
    },
    {
        "m-demare/attempt.nvim",
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
        event = "BufEnter",
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
        event = "BufRead",
        opts = {},
    },
    {
        "ray-x/lsp_signature.nvim",
        event = "BufRead",
        opts = {},
    },
    {
        "rmagatti/goto-preview",
        opts = {
            width = 120,              -- Width of the floating window
            height = 25,              -- Height of the floating window
            default_mappings = false, -- Bind default mappings
            debug = false,            -- Print debug information
            opacity = nil,            -- 0-100 opacity level of the floating window where 100 is fully transparent.
            post_open_hook = nil,     -- A function taking two arguments, a buffer and a window to be ran as a hook.
        },
    },
    {
        "folke/trouble.nvim",
        cmd = { "TroubleToggle", "Trouble" },
        opts = {
            use_diagnostic_signs = true,
        },
    },
}

return M
