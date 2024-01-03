return {
    {
        "Mofiqul/dracula.nvim",
        opts = {
            colors = {
                visual = "#6c7086",
            },
            transparent_bg = true,
            italic_comment = true,
        },
    },
    {
        "rose-pine/neovim",
        event = "VeryLazy",
        name = "rose-pine",
        opts = {
            disable_background = true,
            disable_float_background = true,
        },
    },
    {
        "catppuccin/nvim",
        event = "VeryLazy",
        name = "catppuccin",
        opts = {
            transparent_background = true,
        },
    },
    {
        "bluz71/vim-moonfly-colors",
        event = "VeryLazy",
        name = "moonfly",
        config = function()
            vim.g.moonflyTransparent = true
            vim.g.moonflyUnderlineMatchParen = true
            vim.g.moonflyTerminalColors = true
        end,
    },
    {
        "rebelot/kanagawa.nvim",
        event = "VeryLazy",
        name = "kanagawa",
        opts = {
            transparent = true,
        },
    },
}
