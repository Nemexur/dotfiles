return {
    { "vuciv/golf",       cmd = "Golf" },
    { "romainl/vim-cool", event = "VeryLazy" },
    {
        "obsidian-nvim/obsidian.nvim",
        version = "*",
        ft = "markdown",
        dependencies = { "nvim-lua/plenary.nvim", "folke/snacks.nvim" },
        opts = {
            dir = os.getenv("SECOND_BRAIN"),
            notes_subdir = "0 Inbox",
            new_notes_location = "current_dir",
            completion = {
                nvim_cmp = false,
                blink = true,
                min_chars = 2,
            },
            note_id_func = function(title)
                local suffix = ""
                if title ~= nil then
                    suffix = title
                else
                    -- If title is nil, just add 4 random uppercase letters to the suffix.
                    for _ = 1, 4 do
                        suffix = suffix .. string.char(math.random(65, 90))
                    end
                end
                return suffix .. " " .. tostring(os.time())
            end,
            disable_frontmatter = false,
            mappings = {},
            picker = { name = "snacks.pick" },
            open_notes_in = "current",
        },
        keys = {
            { "<leader>ol", "<cmd>ObsidianFollowLink<cr>",  desc = "Follow link" },
            { "<leader>on", "<cmd>ObsidianNew<cr>",         desc = "New file" },
            { "<leader>of", "<cmd>ObsidianQuickSwitch<cr>", desc = "Quick Switch" },
            { "<leader>ot", "<cmd>ObsidianSearch<cr>",      desc = "Search Inside Notes" },
            {
                "<leader>oo",
                string.format("<leader>o", "<cmd>edit %s<cr>", os.getenv("SECOND_BRAIN")),
                desc = "Open Obsidian",
            },
        },
    },
    {
        "dstein64/vim-startuptime",
        config = function()
            vim.g.startuptime_tries = 10
        end,
        cmd = "StartupTime",
    },
    {
        "tris203/hawtkeys.nvim",
        dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
        config = true,
        cmd = { "Hawtkeys", "HawtkeysAll", "HawtkeysDupes" },
    },
    {
        "chrishrb/gx.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            handler_options = {
                search_engine = "https://search.brave.com/search?q=", -- or you can pass in a custom search engine
            },
        },
        init = function()
            vim.g.netrw_nogx = 1 -- disable netrw gx
        end,
        keys = { { "gx", "<cmd>Browse<cr>", mode = { "n", "x" } } },
    },
    {
        "fredrikaverpil/godoc.nvim",
        version = "*",
        dependencies = {
            { "folke/snacks.nvim" },
            { "nvim-treesitter/nvim-treesitter", opts = { ensure_installed = { "go" } } },
        },
        build = "go install github.com/lotusirous/gostdsym/stdsym@latest",
        cmd = { "GoDoc" },
        opts = { picker = { type = "snacks" } },
    },
    {
        "Wansmer/langmapper.nvim",
        event = "VeryLazy",
        opts = {},
    },
    {
        "m4xshen/hardtime.nvim",
        event = "VeryLazy",
        dependencies = { "MunifTanjim/nui.nvim" },
        opts = {
            max_count = 5,
            disable_mouse = false,
            disabled_keys = {
                ["<Up>"] = false,
                ["<Down>"] = false,
                ["<Left>"] = false,
                ["<Right>"] = false,
            },
        },
    },
}
