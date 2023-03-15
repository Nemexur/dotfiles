local coding_plugins = {
    { "ruifm/gitlinker.nvim" },
    { "gpanders/editorconfig.nvim" },
    {
        "m-demare/attempt.nvim",
        requires = {
            { "nvim-lua/plenary.nvim" },
        },
    },
    {
        "kylechui/nvim-surround",
        event = "BufEnter",
        config = function()
            require("nvim-surround").setup()
        end,
    },
    {
        "echasnovski/mini.trailspace",
        event = "BufEnter",
        config = function()
            require("mini.trailspace").setup()
        end,
    },
    {
        "Wansmer/treesj",
        event = "BufRead",
        config = function()
            require("treesj").setup()
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
        "folke/trouble.nvim",
        cmd = { "TroubleToggle", "Trouble" },
        config = function ()
            require("trouble").setup({
                opts = { use_diagnostic_signs = true },
            })
        end
    },
    {
        "folke/todo-comments.nvim",
        cmd = { "TodoTrouble", "TodoTelescope" },
        event = { "BufReadPost", "BufNewFile" },
    },
}

for _, v in ipairs(coding_plugins) do
    table.insert(lvim.plugins, v)
end
