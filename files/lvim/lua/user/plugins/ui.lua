local M = {}

M.plugins = {
    { "fladson/vim-kitty" },
    { "towolf/vim-helm" },
    { "nvim-telescope/telescope-ui-select.nvim" },
    { "Mofiqul/dracula.nvim" },
    {
        "m4xshen/smartcolumn.nvim",
        opts = {
            colorcolumn = "120",
        },
    },
    {
        "beauwilliams/focus.nvim",
        opts = {
            autoresize = false,
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
