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
        "stevearc/oil.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
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
                ["H"] = "actions.parent",
                ["-"] = "actions.cd",
                ["_"] = "actions.open_cwd",
                ["gS"] = "actions.change_sort",
                ["gx"] = "actions.open_external",
                ["g."] = "actions.toggle_hidden",
                ["g\\"] = "actions.toggle_trash",
            },
            use_default_keymaps = false,
        },
    },
    {
        "lewis6991/gitsigns.nvim",
        event = "User FileOpened",
        cmd = "Gitsigns",
    },
    {
        "andrewferrier/wrapping.nvim",
        lazy = true,
        opts = {},
    },
    {
        "m4xshen/smartcolumn.nvim",
        lazy = true,
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
            })
        end,
    },
    {
        "iamcco/markdown-preview.nvim",
        lazy = true,
        ft = "markdown",
        build = "cd app && npm install",
        config = function()
            vim.g.mkdp_auto_start = 1
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
    },
    {
        "rcarriga/nvim-notify",
        event = "VeryLazy",
        init = function()
            vim.cmd([[ hi NotifyBackground guibg = #000000 ]])
        end,
        opts = {
            background_colour = "#000000",
        },
    },
    {
        "nacro90/numb.nvim",
        event = "BufRead",
        opts = {
            show_numbers = true, -- Enable 'number' for the window while peeking
            show_cursorline = true, -- Enable 'cursorline' for the window while peeking
        },
    },
}
