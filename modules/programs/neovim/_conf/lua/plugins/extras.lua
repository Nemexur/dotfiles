return {
    { "vuciv/golf", cmd = "Golf" },
    { "romainl/vim-cool", event = "VeryLazy" },
    { "bullets-vim/bullets.vim", event = "VeryLazy" },
    {
        "obsidian-nvim/obsidian.nvim",
        version = "*",
        ft = "markdown",
        dependencies = { "nvim-lua/plenary.nvim", "folke/snacks.nvim" },
        opts = {
            legacy_commands = false,
            workspaces = {
                {
                    name = "personal",
                    path = os.getenv("SECOND_BRAIN"),
                },
            },
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
            frontmatter = {
                enabled = true,
            },
            picker = { name = "snacks.pick" },
            open_notes_in = "current",
        },
        keys = {
            { "<leader>ol", "<cmd>Obsidian follow_link<cr>", desc = "Follow [L]ink" },
            { "<leader>on", "<cmd>Obsidian new<cr>", desc = "New [F]ile" },
            { "<leader>of", "<cmd>Obsidian quick_switch<cr>", desc = "Quick Switch" },
            { "<leader>os", "<cmd>Obsidian search<cr>", desc = "[S]earch Inside Notes" },
            {
                "<leader>oo",
                string.format("<leader>o", "<cmd>edit %s<cr>", os.getenv("SECOND_BRAIN")),
                desc = "[O]pen Obsidian",
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
        keys = {
            { "gx", "<cmd>Browse<cr>", mode = { "n", "x" } },
        },
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
    {
        "meznaric/key-analyzer.nvim",
        opts = {},
        cmd = { "KeyAnalyzer" },
    },
    {
        "mistweaverco/kulala.nvim",
        ft = { "http", "rest" },
        keys = {
            { "<leader>Rb", "<cmd>lua require('kulala').scratchpad()<cr>", desc = "Open scratchpad", ft = "http" },
            { "<leader>Rc", "<cmd>lua require('kulala').copy()<cr>", desc = "Copy as cURL", ft = "http" },
            { "<leader>RC", "<cmd>lua require('kulala').from_curl()<cr>", desc = "Paste from curl", ft = "http" },
            {
                "<leader>Rg",
                "<cmd>lua require('kulala').download_graphql_schema()<cr>",
                desc = "Download GraphQL schema",
                ft = "http",
            },
            {
                "<leader>Ri",
                "<cmd>lua require('kulala').inspect()<cr>",
                desc = "Inspect current request",
                ft = "http",
            },
            {
                "<leader>Rn",
                "<cmd>lua require('kulala').jump_next()<cr>",
                desc = "Jump to next request",
                ft = "http",
            },
            {
                "<leader>Rp",
                "<cmd>lua require('kulala').jump_prev()<cr>",
                desc = "Jump to previous request",
                ft = "http",
            },
            {
                "<leader>Rq",
                "<cmd>lua require('kulala').close()<cr>",
                desc = "Close window",
                ft = "http",
            },
            {
                "<leader>Rr",
                "<cmd>lua require('kulala').replay()<cr>",
                desc = "Replay the last request",
                ft = "http",
            },
            {
                "<leader>Rs",
                "<cmd>lua require('kulala').run()<cr>",
                desc = "Send the request",
                ft = "http",
            },
            {
                "<leader>RS",
                "<cmd>lua require('kulala').show_stats()<cr>",
                desc = "Show stats",
                ft = "http",
            },
            {
                "<leader>Rt",
                "<cmd>lua require('kulala').toggle_view()<cr>",
                desc = "Toggle headers/body",
                ft = "http",
            },
        },
    },
}
