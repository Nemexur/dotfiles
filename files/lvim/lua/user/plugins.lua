lvim.plugins = {
    { "folke/todo-comments.nvim" },
    { "ruifm/gitlinker.nvim" },
    { "leoluz/nvim-dap-go" },
    { "olexsmir/gopher.nvim" },
    { "ggandor/leap.nvim" },
    { "nvim-telescope/telescope-ui-select.nvim" },
    {
        "m-demare/attempt.nvim",
        requires = {
            { "nvim-lua/plenary.nvim" },
        },
    },
    {
        "folke/trouble.nvim",
        cmd = "TroubleToggle",
    },
    {
        "kylechui/nvim-surround",
        config = function()
            require("nvim-surround").setup()
        end,
    },
    {
        "windwp/nvim-spectre",
        event = "BufRead",
        config = function()
            require("spectre").setup()
        end,
    },
    {
        "ray-x/lsp_signature.nvim",
        event = "BufRead",
        config = function()
            require("lsp_signature").on_attach()
        end,
    },
    {
        "beauwilliams/focus.nvim",
        config = function()
            require("focus").setup()
        end,
    },
    {
        "m4xshen/autoclose.nvim",
        config = function()
            require("autoclose").setup()
        end,
    },
    {
        "gbprod/yanky.nvim",
        config = function()
            require("yanky").setup()
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
        "gbprod/substitute.nvim",
        config = function()
            require("substitute").setup({
                on_substitute = require("yanky.integration").substitute(),
            })
        end,
    },
    {
        "rmagatti/goto-preview",
        config = function()
            require("goto-preview").setup {
                width = 120, -- Width of the floating window
                height = 25, -- Height of the floating window
                default_mappings = false, -- Bind default mappings
                debug = false, -- Print debug information
                opacity = nil, -- 0-100 opacity level of the floating window where 100 is fully transparent.
                post_open_hook = nil -- A function taking two arguments, a buffer and a window to be ran as a hook.
            }
        end
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
