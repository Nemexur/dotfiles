return {
    { "tpope/vim-rsi", lazy = false },
    { "romainl/vim-cool", event = "VeryLazy" },
    { "tpope/vim-eunuch", event = "VeryLazy" },
    {
        "christoomey/vim-tmux-navigator",
        cmd = {
            "TmuxNavigateLeft",
            "TmuxNavigateDown",
            "TmuxNavigateUp",
            "TmuxNavigateRight",
            "TmuxNavigatePrevious",
        },
        keys = {
            { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
            { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
            { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
            { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
            { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
        },
    },
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
        "laytan/cloak.nvim",
        lazy = false,
        opts = {},
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            require("nvim-autopairs").setup({
                map_c_ = true,
                map_c_w = true,
            })
            require("cmp").event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())
        end,
    },
    {
        "NeogitOrg/neogit",
        opts = {
            integrations = {
                telescope = true,
                diffview = true,
            },
            disable_insert_on_commit = true,
            grap_style = "unicode",
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "sindrets/diffview.nvim",
        },
    },
    {
        "kdheepak/lazygit.nvim",
        cmd = "LazyGit",
        dependencies = { "nvim-lua/plenary.nvim" },
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
        "epwalsh/obsidian.nvim",
        event = "VeryLazy",
        version = "*",
        ft = "markdown",
        opts = {
            dir = os.getenv("SECOND_BRAIN"),
            notes_subdir = "0 Inbox",
            new_notes_location = "current_dir",
            completion = {
                nvim_cmp = true,
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
            disable_frontmatter = true,
            mappings = {},
            finder = "telescope.nvim",
            open_notes_in = "current",
        },
        dependencies = { "nvim-lua/plenary.nvim" },
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
    {
        "chrishrb/gx.nvim",
        keys = { { "gx", "<cmd>Browse<cr>", mode = { "n", "x" } } },
        cmd = { "Browse" },
        init = function()
            vim.g.netrw_nogx = 1 -- disable netrw gx
        end,
        opts = {
            handler_options = {
                search_engine = "https://search.brave.com/search?q=", -- or you can pass in a custom search engine
            },
        },
        dependencies = { "nvim-lua/plenary.nvim" },
    },
}
