return {
    { "stsewd/gx-extended.vim" },
    { "romainl/vim-cool" },
    {
        "dstein64/vim-startuptime",
        cmd = "StartupTime",
        config = function()
            vim.g.startuptime_tries = 10
        end,
    },
    {
        "pwntester/octo.nvim",
        cmd = "Octo",
        opts = {},
    },
    {
        "m4xshen/autoclose.nvim",
        event = "VeryLazy",
        opts = {},
    },
    {
        "NeogitOrg/neogit",
        keys = {
            {
                "<leader>gn",
                function()
                    require("neogit").open({ kind = "tab" })
                end,
                desc = "NeoGit",
            },
        },
        opts = {
            integrations = {
                telescope = true,
                diffview = true,
            },
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "sindrets/diffview.nvim",
            "nvim-telescope/telescope.nvim",
        },
    },
    {
        "kdheepak/lazygit.nvim",
        keys = {
            { "<leader>gl", "<cmd>LazyGit<cr>", desc = "LazyGit" },
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
    },
    {
        "folke/persistence.nvim",
        event = "BufReadPre",
        opts = {
            dir = vim.fn.expand(vim.fn.stdpath("config") .. "/session/"),
            options = { "buffers", "curdir", "tabpages", "winsize" },
        },
    },
    {
        "ecthelionvi/NeoComposer.nvim",
        event = "VeryLazy",
        opts = {},
        dependencies = {
            "kkharji/sqlite.lua",
        },
    },
    {
        "epwalsh/obsidian.nvim",
        event = {
            string.format("BufReadPre %s/**.md", os.getenv("SECOND_BRAIN")),
            string.format("BufNewFile %s/**.md", os.getenv("SECOND_BRAIN")),
        },
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            dir = os.getenv("SECOND_BRAIN"),
            log_level = vim.log.levels.DEBUG,
            notes_subdir = "0 Inbox",
            completion = {
                nvim_cmp = true,
                min_chars = 2,
                new_notes_location = "current_dir",
                prepend_note_id = true,
            },
            note_id_func = function(title)
                return "Untitled"
            end,
            mappings = {},
            finder = "telescope.nvim",
            open_notes_in = "current",
        },
    },
    {
        "tris203/hawtkeys.nvim",
        cmd = { "Hawtkeys", "HawtkeysAll", "HawtkeysDupes" },
        config = true,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
    },
}
