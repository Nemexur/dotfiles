local function dracula_hl()
    local colors = require("dracula").colors()

    local highlights = {
        Normal = { bg = "none" },
        NormalFloat = { bg = "none" },
        CmpItemAbbr = { bg = "none" },
        CmpItemKind = { bg = "none" },
        CmpItemAbbrDeprecated = { bg = "none" },
        CmpItemAbbrMatch = { fg = colors.cyan, bg = "none" },
        NeogitDiffAdd = { fg = colors.green, bg = "#45475a" },
        NeogitDiffAddHighlight = { fg = colors.green, bg = "#45475a" },
        LspInlayHint = { link = "Comment" },
    }
    for group, setting in pairs(highlights) do
        vim.api.nvim_set_hl(0, group, setting)
    end
end

if vim.g.colors_name == "dracula" then
    dracula_hl()
end
