local editor_plugins = {
    { "ggandor/leap.nvim" },
    {
        "windwp/nvim-spectre",
        event = "BufRead",
        config = function()
            require("spectre").setup()
        end,
    },
    {
        "gbprod/yanky.nvim",
        config = function()
            require("yanky").setup()
        end,
    },
    {
        "gbprod/substitute.nvim",
        event = "BufEnter",
        config = function()
            require("substitute").setup({
                on_substitute = require("yanky.integration").substitute(),
            })
        end,
    },
    {
        "andymass/vim-matchup",
        event = "CursorMoved",
        config = function()
            vim.g.matchup_matchparen_offscreen = { method = "popup" }
        end,
    },
    {
        "nacro90/numb.nvim",
        event = "BufRead",
        config = function()
            require("numb").setup {
                show_numbers = true, -- Enable 'number' for the window while peeking
                show_cursorline = true, -- Enable 'cursorline' for the window while peeking
            }
        end,
    },
}

for _, v in ipairs(editor_plugins) do
    table.insert(lvim.plugins, v)
end
