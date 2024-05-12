return {
    {
        "Mofiqul/dracula.nvim",
        event = "VeryLazy",
        config = function()
            require("dracula").setup({
                colors = { visual = "#6e6a86" },
                show_end_of_buffer = false,
                transparent_bg = true,
                italic_comment = true,
                overrides = {},
            })
        end,
    },
    {
        "eldritch-theme/eldritch.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            local transparent = true
            require("eldritch").setup({
                transparent = transparent,
                hide_inactive_statusline = true,
                lualine_bold = true,
                on_highlights = function(highlights, colors)
                    local util = require("eldritch.util")

                    highlights["@variable"] = { fg = colors.white }
                    highlights.Function = { fg = colors.orange }
                    highlights.LineNr = { fg = util.darken(colors.purple, 0.5) }
                    highlights.DiagnosticVirtualTextError = {
                        fg = colors.red,
                        bg = transparent and colors.none or util.darken(colors.red, 0.1),
                    }
                    highlights.DiagnosticVirtualTextWarn = {
                        fg = colors.orange,
                        bg = transparent and colors.none or util.darken(colors.orange, 0.1),
                    }
                    highlights.DiagnosticVirtualTextInfo = {
                        fg = colors.yellow,
                        bg = transparent and colors.none or util.darken(colors.yellow, 0.1),
                    }
                    highlights.DiagnosticVirtualTextHint = {
                        fg = colors.dark_green,
                        bg = transparent and colors.none or util.darken(colors.dark_green, 0.1),
                    }
                end,
            })
            vim.cmd.colorscheme("eldritch")
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
