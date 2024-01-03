return {
    {
        "Mofiqul/dracula.nvim",
        priority = 1000,
        config = function()
            require("dracula").setup({
                show_end_of_buffer = false,
                colors = {
                    visual = "#6e6a86",
                    menu = "none",
                },
                transparent_bg = true,
                italic_comment = true,
                overrides = {
                    Normal = { bg = "none" },
                    NormalFloat = { bg = "none" },
                    PMenu = { bg = "none" },
                    NeogitDiffAdd = { bg = "#45475a", fg = "#50fa7b" },
                    NeogitDiffAddHighlight = { bg = "#45475a", fg = "#50fa7b" },
                },
            })
            vim.cmd.colorscheme("dracula")
        end,
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
