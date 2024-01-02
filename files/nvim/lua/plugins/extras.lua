return {
    { "stsewd/gx-extended.vim" },
    { "romainl/vim-cool" },
    {
        "pwntester/octo.nvim",
        cmd = "Octo",
        opts = {},
    },
    {
        "m4xshen/autoclose.nvim",
        event = "BufReadPre",
        opts = {},
    },
    {
        "kdheepak/lazygit.nvim",
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
        lazy = true,
        opts = {},
        dependencies = { "kkharji/sqlite.lua" },
    },
    {
        "epwalsh/obsidian.nvim",
        lazy = true,
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
}
