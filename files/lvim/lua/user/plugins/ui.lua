local ui_plugins = {
    { "fladson/vim-kitty" },
    { "towolf/vim-helm" },
    { "iamcco/markdown-preview.nvim" },
    { "nvim-telescope/telescope-ui-select.nvim" },
    { "Mofiqul/dracula.nvim" },
    {
        "beauwilliams/focus.nvim",
        config = function()
            require("focus").setup({
                autoresize = false,
            })
        end,
    },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = {
            { "MunifTanjim/nui.nvim" },
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
