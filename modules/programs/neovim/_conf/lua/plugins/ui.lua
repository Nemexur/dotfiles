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
            image = { enabled = true },
            toggle = { enabled = true },
            scratch = { enabled = true },
            gh = { enabled = true },
            notifier = {
                enabled = true,
                style = "compact",
                top_down = false,
            },
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
                desc = "Highlight Groups",
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
                desc = "History",
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
            {
                "<leader>sn",
                function()
                    Snacks.notifier.show_history()
                end,
                desc = "Notifications",
            },
            {
                "<leader>gl",
                function()
                    Snacks.lazygit()
                end,
                desc = "LazyGit",
            },
            {
                "<leader>.",
                function()
                    Snacks.scratch()
                end,
                desc = "Toggle Scratch Buffer",
            },
            {
                "<leader>S",
                function()
                    Snacks.scratch.select()
                end,
                desc = "Select Scratch Buffer",
            },
            {
                "<leader>gi",
                function()
                    Snacks.picker.gh_issue()
                end,
                desc = "GitHub Issues (open)",
            },
            {
                "<leader>gI",
                function()
                    Snacks.picker.gh_issue({ state = "all" })
                end,
                desc = "GitHub Issues (all)",
            },
            {
                "<leader>gp",
                function()
                    Snacks.picker.gh_pr()
                end,
                desc = "GitHub Pull Requests (open)",
            },
            {
                "<leader>gP",
                function()
                    Snacks.picker.gh_pr({ state = "all" })
                end,
                desc = "GitHub Pull Requests (all)",
            },
        },
    },
    {
        "nvim-lualine/lualine.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = { "nvim-tree/nvim-web-devicons" },
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
            local lazy_status = require("lazy.status")
            local colors = require("eldritch.colors")

            local opts = {
                options = {
                    icons_enabled = true,
                    disabled_filetypes = { "snacks_dashboard", "TelescopePrompt" },
                    always_divide_middle = true,
                    globalstatus = true,
                    component_separators = { left = "", right = "" },
                    section_separators = { left = "", right = "" },
                },
                sections = {
                    lualine_a = {
                        {
                            function()
                                if vim.bo.modified then
                                    return " "
                                else
                                    return "󰄳 "
                                end
                            end,
                            separator = { left = "", right = "" },
                            padding = { left = 0, right = 0 },
                        },
                        {
                            "mode",
                            separator = { left = "", right = "" },
                            padding = { left = 0, right = 0 },
                        },
                    },
                    lualine_b = {
                        { "branch", icon = "", separator = "" },
                        { "filename", icon = "" },
                    },
                    lualine_c = {
                        {
                            "filetype",
                            colored = true,
                            icon_only = true,
                            icon = { align = "left" },
                            padding = { left = 1, right = 0 },
                        },
                        {
                            "lsp_status",
                            icon = "",
                            padding = 0,
                            symbols = { done = "", separator = "  " },
                            ignore_lsp = { "copilot" },
                        },
                        {
                            "diagnostics",
                            symbols = { error = " ", warn = " ", hint = "󰌵", info = " " },
                        },
                        function()
                            if vim.bo.readonly then
                                return " "
                            else
                                return ""
                            end
                        end,
                    },
                    lualine_x = {
                        {
                            "diff",
                            symbols = { added = " ", modified = " ", removed = " " },
                        },
                        {
                            lazy_status.updates,
                            cond = lazy_status.has_updates,
                            color = { fg = colors.orange },
                        },
                        function()
                            local reg = vim.fn.reg_recording()
                            if reg ~= "" then
                                return "recording @" .. reg
                            end
                            reg = vim.fn.reg_recorded()
                            if reg ~= "" then
                                return "recorded @" .. reg
                            end

                            return ""
                        end,
                        {
                            "copilot",
                            symbols = {
                                status = {
                                    icons = { unknown = " " },
                                },
                            },
                        },
                    },
                    lualine_y = {
                        { "encoding", right_padding = 2 },
                    },
                    lualine_z = {
                        { "location", padding = 0 },
                        {
                            function()
                                local cursorcol = vim.fn.virtcol(".")
                                if cursorcol >= 10 then
                                    return "  "
                                else
                                    return " "
                                end
                            end,
                            padding = 0,
                        },
                        {
                            "progress",
                            separator = { right = "" },
                            icon = { "󰇽", align = "left" },
                            padding = { left = 0, right = 1 },
                        },
                    },
                },
                extensions = { "oil", "man", "quickfix", "lazy", "trouble", "toggleterm" },
            }

            local theme = require("lualine.themes.auto")
            local lualine_modes = { "insert", "normal", "visual", "command", "replace", "inactive", "terminal" }
            for _, field in ipairs(lualine_modes) do
                if theme[field] and theme[field].c then
                    theme[field].c.bg = colors.none
                end
            end
            opts.options.theme = theme
            require("lualine").setup(opts)
        end,
    },
    {
        "NvChad/nvim-colorizer.lua",
        opts = {},
        keys = {
            { "<leader>uc", "<cmd>ColorizerToggle<cr>", desc = "Toggle Colorizer" },
        },
        cmd = "ColorizerToggle",
    },
    {
        "stevearc/oil.nvim",
        lazy = false,
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            delete_to_trash = true,
            use_default_keymaps = false,
            view_options = { show_hidden = true },
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
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = { "MunifTanjim/nui.nvim" },
        opts = {
            background_colour = "#000000",
            cmdline = { enabled = true },
            messages = { enabled = true },
            notify = { enabled = false },
            lsp = {
                progress = { enabled = true },
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true,
                },
            },
            routes = {
                {
                    filter = {
                        event = "msg_show",
                        any = {
                            { find = "%d+L, %d+B" },
                            { find = "; after #%d+" },
                            { find = "; before #%d+" },
                        },
                    },
                    view = "mini",
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
        "chrisgrieser/nvim-origami",
        event = "VeryLazy",
        init = function()
            vim.opt.foldlevel = 99
            vim.opt.foldlevelstart = 99
        end,
        opts = {
            foldKeymaps = {
                setup = false,
            },
        },
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            { "nvim-mini/mini.icons", version = false },
        },
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        opts = {
            preset = "helix",
            defaults = {},
            triggers = {
                { "<auto>", mode = "nxso" },
                { "s", mode = "nxso" },
            },
            spec = {
                { "<leader><leader>", group = "Exec", icon = "" },
                { "<leader>a", group = "[A]I", icon = "󰵰" },
                { "<leader>c", group = "[C]oding", icon = "" },
                { "<leader>o", group = "[O]bsidian", icon = "" },
                { "<leader>r", group = "[R]eplace", icon = "" },
                { "<leader>t", group = "[T]ab", icon = "" },
                { "<leader>b", group = "[B]uffers", icon = "" },
                { "<leader>x", group = "E[x]tra", icon = "" },
                { "<leader>g", group = "[G]it", icon = "" },
                { "<leader>gh", group = "Signs", icon = "" },
                { "<leader>f", group = "[F]ind", icon = "󰀶" },
                { "<leader>s", group = "[S]earch", icon = "" },
                { "<leader>l", group = "[L]SP", icon = "󰒋" },
                { "<leader>t", group = "Anno[T]aions", icon = "" },
                { "<leader>d", group = "[D]ebug", icon = "" },
                { "<leader>n", group = "[N]ode", icon = "" },
                { "<leader>q", group = "[Q]uickFix Lists", icon = "󱉯" },
                { "<leader>R", group = "[R]est", icon = "󰖟" },
                { "<leader>u", group = "[U]I", icon = "" },
                { "<leader><leader>l", "<cmd>. lua<cr>", desc = "Execute the current line", mode = "n" },
                { "<leader><leader>x", "<cmd>source %<cr>", desc = "Execute the current file", mode = "n" },
                { "<leader>bp", "<cmd>bprevious<cr>", desc = "Previous", mode = "n" },
                { "<leader>bn", "<cmd>bnext<cr>", desc = "Next", mode = "n" },
                { "<leader>bW", "<cmd>noautocmd w<cr>", desc = "Save without formatting (noautocmd)", mode = "n" },
                { "<leader>bq", "<cmd>bd<cr>", desc = "[Q]uit [B]uffer", mode = "n" },
                { "<leader>ut", "<cmd>tabclose<cr>", desc = "Tab Close" },
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
            { "<leader>rr", "<cmd>lua require('spectre').open()<cr>", desc = "[R]eplace" },
            {
                "<leader>rw",
                "<cmd>lua require('spectre').open_visual({select_word=true})<cr>",
                desc = "[R]eplace [W]ord",
            },
            {
                "<leader>rb",
                "<cmd>lua require('spectre').open_file_search()<cr>",
                desc = "[R]eplace [B]uffer",
            },
        },
    },
    {
        "MagicDuck/grug-far.nvim",
        cmd = "GrugFar",
        opts = { windowCreationCommand = "vsplit", startInInsertMode = false },
        keys = {
            { "<leader>rg", "<cmd>GrugFar<cr>", desc = "[R]eplace with [G]rugFar" },
        },
    },
}
