return {
    {
        "nvim-lualine/lualine.nvim",
        event = "VimEnter",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            options = {
                theme = "dracula-nvim",
            },
        },
    },
    {
        "NvChad/nvim-colorizer.lua",
        cmd = "ColorizerToggle",
        opts = {},
    },
    {
        "stevearc/oil.nvim",
        event = "VimEnter",
        opts = {
            delete_to_trash = true,
            keymaps = {
                ["g?"] = "actions.show_help",
                ["<CR>"] = "actions.select",
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
            use_default_keymaps = false,
        },
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    {
        "lewis6991/gitsigns.nvim",
        event = "VeryLazy",
    },
    {
        "andrewferrier/wrapping.nvim",
        event = "VeryLazy",
        opts = {},
    },
    {
        "m4xshen/smartcolumn.nvim",
        event = "VeryLazy",
        opts = {
            colorcolumn = "120",
        },
    },
    {
        "anuvyklack/windows.nvim",
        event = "WinNew",
        dependencies = {
            { "anuvyklack/middleclass" },
            { "anuvyklack/animation.nvim", enabled = false },
        },
        keys = { { "<leader>wm", "<cmd>WindowsMaximize<cr>", desc = "Windows Maximize" } },
        config = function()
            vim.o.winwidth = 5
            vim.o.equalalways = false
            require("windows").setup({
                animation = { enable = false, duration = 150 },
                ignore = {
                    buftype = { "quickfix" },
                    filetype = { "NvimTree", "neo-tree", "undotree", "NeogitStatus" },
                },
            })
        end,
    },
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = "cd app && yarn install",
        init = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
    },
    {
        "jinh0/eyeliner.nvim",
        event = "VeryLazy",
        config = function()
            require("eyeliner").setup()
            vim.api.nvim_set_hl(0, "EyelinerPrimary", { bold = true, italic = true })
            vim.api.nvim_set_hl(0, "EyelinerSecondary", { underline = true })
        end,
    },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = {
            { "MunifTanjim/nui.nvim" },
            { "rcarriga/nvim-notify" },
        },
        opts = {
            lsp = {
                signature = {
                    enabled = false,
                },
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true,
                },
            },
            presets = {
                bottom_search = true, -- use a classic bottom cmdline for search
                command_palette = true, -- position the cmdline and popupmenu together
                long_message_to_split = true, -- long messages will be sent to a split
                inc_rename = true, -- enables an input dialog for inc-rename.nvim
                lsp_doc_border = true, -- add a border to hover docs and signature help
            },
        },
    },
    {
        "rcarriga/nvim-notify",
        event = "VeryLazy",
        opts = {
            background_colour = "#000000",
        },
    },
    {
        "nacro90/numb.nvim",
        event = "VeryLazy",
        opts = {
            show_numbers = true, -- Enable 'number' for the window while peeking
            show_cursorline = true, -- Enable 'cursorline' for the window while peeking
        },
    },
}
