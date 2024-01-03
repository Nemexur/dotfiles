return {
    {
        "VonHeikemen/lsp-zero.nvim",
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
            { "cmp-buffer" },
            { "cmp-path" },
            { "cmp_luasnip" },
            { "cmp-nvim-lsp" },
            { "cmp-nvim-lua" },
            { "cmp-cmdline" },
        },
    },
    {
        "onsails/lspkind.nvim",
        lazy = true,
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
        "neovim/nvim-lspconfig",
        event = { "BufReadPost", "BufNewFile", "BufWritePre" },
        dependencies = { "mason-lspconfig.nvim", "nlsp-settings.nvim" },
    },
    {
        "nvimtools/none-ls.nvim",
        lazy = true,
        event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    },
    {
        "williamboman/mason-lspconfig.nvim",
        event = { "BufReadPost", "BufNewFile", "BufWritePre" },
        cmd = { "LspInstall", "LspUninstall" },
        dependencies = "mason.nvim",
    },
    {
        "tamago324/nlsp-settings.nvim",
        lazy = true,
        event = { "BufReadPost", "BufNewFile", "BufWritePre" },
        cmd = "LspSettings",
    },
    {
        "williamboman/mason.nvim",
        cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
        opts = {},
        build = function()
            pcall(function()
                require("mason-registry").refresh()
            end)
        end,
    },
    {
        "jay-babu/mason-null-ls.nvim",
        event = { "BufReadPost", "BufNewFile", "BufWritePre" },
        opts = {},
        dependencies = {
            "williamboman/mason.nvim",
            "nvimtools/none-ls.nvim",
        },
    },
    {
        "hrsh7th/nvim-cmp",
        event = { "InsertEnter", "CmdlineEnter" },
        dependencies = {
            "cmp-nvim-lsp",
            "cmp-nvim-lua",
            "cmp_luasnip",
            "cmp-buffer",
            "cmp-path",
            "cmp-cmdline",
        },
    },
    {
        "hrsh7th/cmp-nvim-lsp",
        lazy = true,
    },
    {
        "hrsh7th/cmp-nvim-lua",
        lazy = true,
    },
    {
        "saadparwaiz1/cmp_luasnip",
        lazy = true,
    },
    {
        "hrsh7th/cmp-buffer",
        lazy = true,
    },
    {
        "hrsh7th/cmp-path",
        lazy = true,
    },
    {
        "hrsh7th/cmp-cmdline",
        lazy = true,
    },
    {
        "rafamadriz/friendly-snippets",
        lazy = true,
    },
    {
        "saadparwaiz1/cmp_luasnip",
        lazy = true,
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
        opts = {},
    },
}
