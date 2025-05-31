return {
    {
        "eldritch-theme/eldritch.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            local transparent = true
            require("eldritch").setup({
                transparent = transparent,
                hide_inactive_statusline = false,
                lualine_bold = true,
                use_background = false,
                sidebars = { "help" },
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
                    highlights.BqfPreviewBorder = { fg = colors.fg, bg = colors.none }
                    highlights.BlinkCmpDoc = { fg = colors.fg, bg = colors.none }
                    highlights.BlinkCmpDocBorder = { fg = colors.green, bg = colors.none }
                    highlights.BlinkCmpMenu = { fg = colors.fg, bg = colors.none }
                    highlights.BlinkCmpMenuBorder = { fg = colors.green, bg = colors.none }
                    highlights.BlinkCmpMenuSelection = { fg = colors.white, bg = util.darken(colors.purple, 0.4) }
                    highlights.SnacksIndent = { fg = util.darken(colors.purple, 0.3) }
                    highlights.NoiceMini = { bg = colors.none }
                    highlights.NoiceFormatProgressTodo = { fg = util.darken(colors.fg, 0.7) }
                end,
            })
            vim.cmd.colorscheme("eldritch")
        end,
    },
    {
        "Mofiqul/dracula.nvim",
        config = function()
            local dracula = require("dracula")
            local colors = dracula.colors()
            dracula.setup({
                colors = { visual = "#6e6a86" },
                show_end_of_buffer = false,
                transparent_bg = true,
                italic_comment = true,
                overrides = {
                    Normal = { bg = colors.none },
                    NormalFloat = { bg = colors.none },
                    CmpItemAbbr = { bg = colors.none },
                    CmpItemKind = { bg = colors.none },
                    BlinkCmpMenu = { bg = colors.none },
                    CmpItemAbbrDeprecated = { bg = colors.none },
                    CmpItemAbbrMatch = { fg = colors.cyan, bg = colors.none },
                    NeogitDiffAdd = { fg = colors.green, bg = "#45475a" },
                    NeogitDiffAddHighlight = { fg = colors.green, bg = "#45475a" },
                    LspInlayHint = { link = "Comment" },
                },
            })
        end,
    },
    {
        "rose-pine/neovim",
        name = "rose-pine",
        opts = { disable_background = true, disable_float_background = true },
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        opts = { transparent_background = true },
    },
    {
        "bluz71/vim-moonfly-colors",
        name = "moonfly",
        config = function()
            vim.g.moonflyTransparent = true
            vim.g.moonflyUnderlineMatchParen = true
            vim.g.moonflyTerminalColors = true
        end,
    },
    {

        "rebelot/kanagawa.nvim",
        name = "kanagawa",
        opts = { transparent = true },
    },
}
