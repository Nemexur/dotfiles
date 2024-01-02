local M = {}

M.plugins = {
    { "fladson/vim-kitty" },
    { "towolf/vim-helm" },
    { "nvim-telescope/telescope-ui-select.nvim" },
    { "nvim-telescope/telescope-file-browser.nvim" },
    {
        "Mofiqul/dracula.nvim",
        opts = {
            colors = {
                visual = "#9197D4",
            },
            transparent_bg = true,
            italic_comment = true,
        },
    },
    {
        "rose-pine/neovim",
        name = "rose-pine",
    },
    { "nvim-treesitter/nvim-treesitter-textobjects" },
    {
        "nvim-treesitter/nvim-treesitter-context",
        opts = {
            max_lines = 1,
        },
    },
    {
        "m4xshen/smartcolumn.nvim",
        opts = {
            colorcolumn = "120",
        },
    },
    {
        "beauwilliams/focus.nvim",
        version = "*",
        opts = {},
        keys = {
            {
                "<leader>wf",
                "<cmd>FocusToggle<cr>",
                mode = { "n" },
                desc = "Toggle Focus",
            },
        },
    },
    {
        "iamcco/markdown-preview.nvim",
        ft = "markdown",
        build = "cd app && npm install",
        config = function()
            vim.g.mkdp_auto_start = 1
        end,
    },
    {
        "stevearc/oil.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            delete_to_trash = true,
        },
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
        },
        opts = {
            messages = {
                enabled = false,
            },
            popupmenu = {
                enabled = true,
                backend = "nui",
                kind_icons = {},
            },
            notify = {
                enabled = false,
            },
            lsp = {
                progress = {
                    enabled = false,
                },
                hover = {
                    enabled = false,
                },
                signature = {
                    enabled = false,
                },
                message = {
                    enabled = false,
                },
            },
            presets = {
                bottom_search = true,
                command_palette = true,
                long_message_to_split = true,
            },
        }
    },
}

return M
