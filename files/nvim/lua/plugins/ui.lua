return {
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        opts = {
            bigfile = { enabled = true },
            dashboard = { enabled = true },
            input = { enabled = true },
            quickfile = { enabled = true },
            words = { enabled = true },
            terminal = { enabled = true },
            picker = {
                enabled = true,
                win = {
                    input = {
                        keys = {
                            ["<C-y>"] = { "confirm", mode = { "n", "i" } },
                            ["<a-g>"] = { "toggle_ignored", mode = { "i", "n" } },
                        },
                    },
                    list = {
                        keys = {
                            ["<a-g>"] = "toggle_ignored",
                        },
                    },
                },
            },
            indent = {
                enabled = true,
                animate = {
                    enabled = vim.fn.has("nvim-0.10") == 1,
                    style = "out",
                    easing = "linear",
                    duration = { step = 20, total = 100 },
                },
            },
        },
        keys = {
            {
                "<leader>,",
                function()
                    Snacks.picker.buffers()
                end,
                desc = "Switch Buffer",
            },
            {
                "<leader>:",
                function()
                    Snacks.picker.command_history()
                end,
                desc = "Command History",
            },
            {
                "<c-t>",
                function()
                    Snacks.terminal()
                end,
                desc = "Toggle Terminal",
            },
            -- find
            {
                "<leader>ff",
                function()
                    Snacks.picker.files({ hidden = true })
                end,
                desc = "Find Files (cwd)",
            },
            {
                "<leader>fg",
                function()
                    Snacks.picker.git_files()
                end,
                desc = "Find Files (git-files)",
            },
            {
                "<leader>bb",
                function()
                    Snacks.picker.buffers()
                end,
                desc = "Buffers",
            },
            {
                "<leader>fr",
                function()
                    Snacks.picker.recent()
                end,
                desc = "Recent",
            },
            {
                "<leader>fc",
                function()
                    Snacks.picker.colorschemes()
                end,
                desc = "Colorscheme with Preview",
            },
            {
                "<leader>fs",
                function()
                    Snacks.picker.spelling()
                end,
                desc = "Spell",
            },
            -- search
            {
                '<leader>s"',
                function()
                    Snacks.picker.registers()
                end,
                desc = "Registers",
            },
            {
                "<leader>sg",
                function()
                    Snacks.picker.grep()
                end,
                desc = "Grep (cwd)",
            },
            {
                "<leader>sb",
                function()
                    Snacks.picker.lines()
                end,
                desc = "Grep (buffer)",
            },
            {
                "<leader>sa",
                function()
                    Snacks.picker.autocmds()
                end,
                desc = "Auto Commands",
            },
            {
                "<leader>sc",
                function()
                    Snacks.picker.command_history()
                end,
                desc = "Command History",
            },
            {
                "<leader>sC",
                function()
                    Snacks.picker.commands()
                end,
                desc = "Commands",
            },
            {
                "<leader>sd",
                function()
                    Snacks.picker.diagnostics()
                end,
                desc = "Diagnostics",
            },
            {
                "<leader>sD",
                function()
                    Snacks.picker.diagnostics_buffer()
                end,
                desc = "Buffer Diagnostics",
            },
            {
                "<leader>sh",
                function()
                    Snacks.picker.help()
                end,
                desc = "Help Pages",
            },
            {
                "<leader>sH",
                function()
                    Snacks.picker.highlights()
                end,
                desc = "Search Highlight Groups",
            },
            {
                "<leader>sj",
                function()
                    Snacks.picker.jumps()
                end,
                desc = "Jumplist",
            },
            {
                "<leader>sk",
                function()
                    Snacks.picker.keymaps()
                end,
                desc = "Key Maps",
            },
            {
                "<leader>sM",
                function()
                    Snacks.picker.man()
                end,
                desc = "Man Pages",
            },
            {
                "<leader>sm",
                function()
                    Snacks.picker.marks()
                end,
                desc = "Jump to Mark",
            },
            {
                "<leader>sr",
                function()
                    Snacks.picker.resume()
                end,
                desc = "Resume",
            },
            {
                "<leader>si",
                function()
                    Snacks.picker.icons()
                end,
                desc = "Icons & Emoji",
            },
            {
                "<leader>s/",
                function()
                    Snacks.picker.search_history()
                end,
                desc = "Search History",
            },
            {
                "<leader>su",
                function()
                    Snacks.picker.undo({
                        win = {
                            preview = { wo = { number = false, relativenumber = false, signcolumn = "no" } },
                            input = {
                                keys = {
                                    ["<c-a>"] = { "yank_add", mode = { "n", "i" } },
                                    ["<c-x>"] = { "yank_del", mode = { "n", "i" } },
                                },
                            },
                        },
                        actions = {
                            yank_add = { action = "yank", field = "added_lines", notify = false },
                            yank_del = { action = "yank", field = "removed_lines", notify = false },
                        },
                    })
                end,
                desc = "Undotree",
            },
        },
    },
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        init = function()
            vim.g.lualine_laststatus = vim.o.laststatus
            if vim.fn.argc(-1) > 0 then
                -- set an empty statusline till lualine loads
                vim.o.statusline = " "
            else
                -- hide the statusline on the starter page
                vim.o.laststatus = 0
            end
        end,
        config = function()
            local colors = require("eldritch.colors")

            require("lualine").setup({
                extensions = { "quickfix", "oil", "trouble" },
                options = {
                    theme = "eldritch",
                    component_separators = { left = "", right = "" },
                    section_separators = { left = "", right = "" },
                },
            })
            for _, section in ipairs({ "a", "b", "c" }) do
                vim.api.nvim_set_hl(
                    0,
                    "lualine_" .. section .. "_inactive",
                    { fg = colors.fg, bg = colors.none, bold = true }
                )
            end
        end,
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    {
        "NvChad/nvim-colorizer.lua",
        opts = {},
        cmd = "ColorizerToggle",
    },
    {
        "stevearc/oil.nvim",
        event = "VimEnter",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            delete_to_trash = true,
            use_default_keymaps = false,
            keymaps = {
                ["g?"] = "actions.show_help",
                ["<CR>"] = "actions.select",
                ["<C-y>"] = "actions.select",
                ["gs"] = "actions.select_vsplit",
                ["<C-t>"] = "actions.select_tab",
                ["<C-p>"] = "actions.preview",
                ["<C-c>"] = "actions.close",
                ["q"] = "actions.close",
                ["gr"] = "actions.refresh",
                ["-"] = "actions.parent",
                ["_"] = "actions.open_cwd",
                ["`"] = "actions.cd",
                ["~"] = "actions.tcd",
                ["gS"] = "actions.change_sort",
                ["gx"] = "actions.open_external",
                ["g."] = "actions.toggle_hidden",
                ["g\\"] = "actions.toggle_trash",
            },
            view_options = {
                show_hidden = true,
            },
        },
        keys = {
            { "<leader>e", "<cmd>Oil<cr>", desc = "Open parent directory", mode = "n" },
        },
    },
    {
        "andrewferrier/wrapping.nvim",
        opts = {
            notify_on_switch = true,
            create_commands = false,
            create_keymaps = false,
        },
        keys = {
            {
                "<leader>bw",
                "<cmd>lua require('wrapping').toggle_wrap_mode()<cr>",
                desc = "Toggle wrapping",
            },
        },
    },
    {
        "m4xshen/smartcolumn.nvim",
        event = "VeryLazy",
        opts = { colorcolumn = "100" },
    },
    {
        "iamcco/markdown-preview.nvim",
        ft = "markdown",
        build = "cd app && yarn install",
        init = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = { "MunifTanjim/nui.nvim" },
        opts = {
            background_colour = "#000000",
            messages = {
                enabled = true,
            },
            notify = {
                enabled = false,
            },
            lsp = {
                progress = {
                    enabled = true,
                },
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true,
                },
            },
            presets = {
                bottom_search = false,
                command_palette = true,
                long_message_to_split = true,
                inc_rename = true,
                lsp_doc_border = true,
            },
        },
    },
    {
        "laytan/cloak.nvim",
        event = "VimEnter",
        opts = {},
        keys = {
            { "<leader>bc", "<cmd>CloakToggle<cr>", desc = "Toggle Cloak" },
        },
    },
    {
        "ThePrimeagen/harpoon",
        dependencies = { "nvim-lua/plenary.nvim" },
        branch = "harpoon2",
        opts = {},
        keys = {
            {
                "<C-e>",
                function()
                    local harpoon = require("harpoon")
                    harpoon.ui:toggle_quick_menu(harpoon:list())
                end,
                desc = "Harpoon List",
            },
            {
                "<leader>h",
                "<cmd>lua require('harpoon'):list():add()<CR>",
                desc = "Harpoon Append",
            },
        },
    },
    {
        "folke/todo-comments.nvim",
        keys = {
            {
                "<leader>st",
                function()
                    Snacks.picker.todo_comments()
                end,
                desc = "Todo",
            },
            {
                "<leader>sT",
                function()
                    Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } })
                end,
                desc = "Todo/Fix/Fixme",
            },
        },
        opts = {},
    },
    {
        "kevinhwang91/nvim-ufo",
        dependencies = { "kevinhwang91/promise-async" },
        opts = {
            open_fold_hl_timeout = 0,
            provider_selector = function(bufnr, filetype, buftype)
                return { "lsp", "indent" }
            end,
        },
        keys = {
            { "<leader>z", "za", desc = "Toggle Folding" },
            { "zR", "<cmd>lua require('ufo').openAllFolds()<cr>", desc = "Open all folds" },
            { "zM", "<cmd>lua require('ufo').closeAllFolds()<cr>", desc = "Close all folds" },
        },
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        dependencies = {
            "echasnovski/mini.icons",
            "nvim-tree/nvim-web-devicons",
        },
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        opts = {
            preset = "helix",
            defaults = {},
            spec = {
                { "<leader><leader>", group = "Exec", icon = "" },
                { "<leader><leader>l", "<cmd>. lua<cr>", desc = "Execute the current line", mode = "n" },
                { "<leader><leader>x", "<cmd>source %<cr>", desc = "Exectue the current file", mode = "n" },
                { "<leader>c", group = "Coding", icon = "" },
                { "<leader>o", group = "Obsidian", icon = "" },
                { "<leader>r", group = "Replace", icon = "" },
                { "<leader>t", group = "Tab" },
                { "<leader>tq", "<cmd>tabclose<cr>", desc = "Close" },
                { "<leader>b", group = "Buffers" },
                { "<leader>bp", "<cmd>bprevious<cr>", desc = "Previous", mode = "n" },
                { "<leader>bn", "<cmd>bnext<cr>", desc = "Next", mode = "n" },
                { "<leader>bW", "<cmd>noautocmd w<cr>", desc = "Save without formatting (noautocmd)", mode = "n" },
                { "<leader>bq", "<cmd>bd<cr>", desc = "Quit buffer", mode = "n" },
                { "<leader>x", group = "Extra", icon = "" },
                { "<leader>g", group = "Git", icon = "" },
                { "<leader>f", group = "Find" },
                { "<leader>s", group = "Search" },
                { "<leader>l", group = "LSP", icon = "󰒋" },
                { "<leader>a", group = "Annotaions", icon = "" },
                { "<leader>d", group = "Debug", icon = "" },
                { "<leader>n", group = "Node", icon = "" },
                { "<leader>q", group = "FixLists", icon = "󱉯" },
            },
        },
        keys = {
            {
                "<leader>?",
                function()
                    require("which-key").show({ global = false })
                end,
                desc = "Buffer Local Keymaps (which-key)",
            },
        },
    },
    {
        "nvim-pack/nvim-spectre",
        opts = {},
        keys = {
            { "<leader>rr", "<cmd>lua require('spectre').open()<cr>", desc = "Replace" },
            {
                "<leader>rw",
                "<cmd>lua require('spectre').open_visual({select_word=true})<cr>",
                desc = "Replace Word",
            },
            {
                "<leader>rb",
                "<cmd>lua require('spectre').open_file_search()<cr>",
                desc = "Replace Buffer",
            },
        },
    },
    {
        "MagicDuck/grug-far.nvim",
        opts = {
            windowCreationCommand = "vsplit",
            startInInsertMode = false,
        },
        cmd = "GrugFar",
        keys = {
            { "<leader>rg", "<cmd>GrugFar<cr>", desc = "[R]eplace with [G]rugFar" },
        },
    },
}
