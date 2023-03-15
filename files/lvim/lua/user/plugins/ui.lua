local ui_plugins = {
    { "fladson/vim-kitty" },
    { "towolf/vim-helm" },
    { "iamcco/markdown-preview.nvim" },
    { "nvim-telescope/telescope-ui-select.nvim" },
    {
        "beauwilliams/focus.nvim",
        config = function() require("focus").setup() end,
    },
}

for _, v in ipairs(ui_plugins) do
    table.insert(lvim.plugins, v)
end
