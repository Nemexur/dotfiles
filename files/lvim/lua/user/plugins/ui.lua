local ui_plugins = {
    { "fladson/vim-kitty" },
    { "towolf/vim-helm" },
    { "iamcco/markdown-preview.nvim" },
    { "nvim-telescope/telescope-ui-select.nvim" },
    {
        "beauwilliams/focus.nvim",
        config = function()
            require("focus").setup()
        end,
    },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = {
            { "MunifTanjim/nui.nvim" },
            { "rcarriga/nvim-notify" },
        },
        config = function()
            require("noice").setup({
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
                views = {
                    cmdline_popup = {
                        position = {
                            row = 5,
                            col = "50%",
                        },
                        size = {
                            width = 60,
                            height = "auto",
                        },
                    },
                    popupmenu = {
                        relative = "editor",
                        position = {
                            row = 8,
                            col = "50%",
                        },
                        size = {
                            width = 60,
                            height = 10,
                        },
                        border = {
                            style = "rounded",
                            padding = { 0, 1 },
                        },
                        win_options = {
                            winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
                        },
                    },
                },
                presets = {
                    bottom_search = true,
                    command_palette = true,
                    long_message_to_split = true,
                },
            })
        end,
    },
}

for _, v in ipairs(ui_plugins) do
    table.insert(lvim.plugins, v)
end
