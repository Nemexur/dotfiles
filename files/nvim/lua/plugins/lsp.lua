return {
    {
        "VonHeikemen/lsp-zero.nvim",
        event = "VeryLazy",
        branch = "v3.x",
        config = false,
        init = function()
            -- Disable automatic setup, we are doing it manually
            vim.g.lsp_zero_extend_cmp = 0
            vim.g.lsp_zero_extend_lspconfig = 0
        end,
        dependencies = {
            -- LSP Support
            { "nvim-lspconfig" },
            { "mason.nvim" },
            { "mason-lspconfig.nvim" },
            { "none-ls.nvim" },
            { "nlsp-settings.nvim" },
            -- Autocompletion
            { "nvim-cmp" },
        },
    },
    {
        "neovim/nvim-lspconfig",
        event = "VeryLazy",
        dependencies = { "mason-lspconfig.nvim", "nlsp-settings.nvim" },
    },
    {
        "williamboman/mason-lspconfig.nvim",
        event = "VeryLazy",
        cmd = { "LspInstall", "LspUninstall" },
        dependencies = "mason.nvim",
    },
    {
        "tamago324/nlsp-settings.nvim",
        event = "VeryLazy",
        cmd = "LspSettings",
    },
    {
        "williamboman/mason.nvim",
        cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
        opts = {},
    },
    {
        "jay-babu/mason-null-ls.nvim",
        event = "VeryLazy",
        opts = {},
        dependencies = {
            "williamboman/mason.nvim",
            "nvimtools/none-ls.nvim",
        },
    },
    {
        "nvimtools/none-ls.nvim",
        event = "VeryLazy",
    },
    {
        "L3MON4D3/LuaSnip",
        event = "InsertEnter",
        dependencies = {
            "friendly-snippets",
            "cmp_luasnip",
        },
    },
    {
        "folke/neodev.nvim",
        event = "VeryLazy",
        opts = {},
    },
    {
        "onsails/lspkind.nvim",
        event = "VeryLazy",
        init = function()
            require("lspkind").init({
                mode = "symbol_text",
                preset = "codicons",
                symbol_map = {
                    Text = "󰉿",
                    Method = "󰆧",
                    Function = "󰊕",
                    Constructor = "",
                    Field = "󰜢",
                    Variable = "󰀫",
                    Class = "󰠱",
                    Interface = "",
                    Module = "",
                    Property = "󰜢",
                    Unit = "󰑭",
                    Value = "󰎠",
                    Enum = "",
                    Keyword = "󰌋",
                    Snippet = "",
                    Color = "󰏘",
                    File = "󰈙",
                    Reference = "󰈇",
                    Folder = "󰉋",
                    EnumMember = "",
                    Constant = "󰏿",
                    Struct = "󰙅",
                    Event = "",
                    Operator = "󰆕",
                    TypeParameter = "",
                },
            })
        end,
    },
    {
        "hrsh7th/nvim-cmp",
        lazy = false,
        event = { "InsertEnter", "CmdlineEnter" },
        dependencies = {
            { "cmp-nvim-lsp" },
            { "cmp-nvim-lua" },
            { "cmp-buffer" },
            { "cmp-cmdline" },
            { "cmp-path" },
            { "cmp-calc" },
            { "cmp-emoji" },
            { "cmp_luasnip" },
            { "cmp-treesitter" },
        },
    },
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-nvim-lua" },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-cmdline" },
    { "hrsh7th/cmp-path" },
    { "hrsh7th/cmp-calc" },
    { "hrsh7th/cmp-emoji" },
    { "ray-x/cmp-treesitter" },
    { "saadparwaiz1/cmp_luasnip" },
    { "rafamadriz/friendly-snippets" },
}
