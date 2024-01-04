return {
    {
        "Mofiqul/dracula.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            local dracula = require("dracula")
            local colors = dracula.colors()

            dracula.setup({
                show_end_of_buffer = false,
                colors = {
                    visual = "#6e6a86",
                },
                transparent_bg = true,
                italic_comment = true,
                overrides = {
                    Normal = { bg = "none" },
                    NormalFloat = { bg = "none" },
                    PMenu = { bg = "none" },
                    CmpItemAbbr = { bg = "none" },
                    CmpItemKind = { bg = "none" },
                    CmpItemAbbrDeprecated = { bg = "none" },
                    CmpItemAbbrMatch = { fg = colors.cyan, bg = "none" },
                    NeogitDiffAdd = { fg = colors.green, bg = "#45475a" },
                    NeogitDiffAddHighlight = { fg = colors.green, bg = "#45475a" },
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
