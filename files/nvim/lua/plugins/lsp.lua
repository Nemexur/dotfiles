return {
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v3.x",
        config = false,
        init = function()
            vim.g.lsp_zero_extend_cmp = 0
            vim.g.lsp_zero_extend_lspconfig = 0
        end,
    },
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        config = function()
            local lsp_zero = require("lsp-zero")
            lsp_zero.extend_cmp()

            local cmp = require("cmp")
            local cmp_action = lsp_zero.cmp_action()

            cmp.setup({
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                sources = {
                    { name = "nvim_lsp" },
                    { name = "nvim_lua" },
                    { name = "luasnip" },
                    { name = "buffer" },
                    { name = "path" },
                    { name = "emoji" },
                    { name = "treesitter" },
                },
                formatting = {
                    fields = { "abbr", "kind", "menu" },
                    format = require("lspkind").cmp_format({ mode = "symbol_text" }),
                    expandable_indicator = true,
                },
                preselect = "item",
                completion = {
                    keyword_length = 1,
                    completeopt = "menu,menuone,noinsert,noselect",
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-k>"] = cmp.mapping(
                        cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
                        { "i", "c" }
                    ),
                    ["<C-j>"] = cmp.mapping(
                        cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
                        { "i", "c" }
                    ),
                    ["<Up>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
                    ["<Down>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
                    ["<C-c>"] = cmp.mapping.abort(),
                    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-u>"] = cmp.mapping.scroll_docs(4),
                    ["<CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true }),
                    ["<Tab>"] = cmp_action.luasnip_supertab(),
                    ["<S-Tab>"] = cmp_action.luasnip_shift_supertab(),
                }),
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
            })
        end,
        dependencies = {
            "L3MON4D3/LuaSnip",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-emoji",
            "saadparwaiz1/cmp_luasnip",
            "ray-x/cmp-treesitter",
            "onsails/lspkind.nvim",
        },
    },
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            local lsp_zero = require("lsp-zero")

            lsp_zero.on_attach(function(client, bufnr)
                lsp_zero.default_keymaps({
                    buffer = bufnr,
                    preserve_mappings = false,
                })
                require("lsp_signature").on_attach({ bind = true, handler_opts = { border = "rounded" } }, bufnr)
            end)

            lsp_zero.format_on_save({
                format_opts = {
                    async = false,
                    timeout_ms = 10000,
                },
                servers = {
                    ["null-ls"] = { "lua", "go", "json", "md" },
                },
            })
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "ansiblels",
                    "bashls",
                    "clangd",
                    "docker_compose_language_service",
                    "dockerls",
                    "gopls",
                    "golangci_lint_ls",
                    "helm_ls",
                    "jsonls",
                    "lua_ls",
                    "pyright",
                    "ruff_lsp",
                    "sqlls",
                    "vimls",
                    "yamlls",
                    "rust_analyzer",
                },
                handlers = {
                    lsp_zero.default_setup,
                    lua_ls = function()
                        local lua_opts = lsp_zero.nvim_lua_ls()
                        require("lspconfig").lua_ls.setup(lua_opts)
                    end,
                },
            })
        end,
        dependencies = {
            "folke/neodev.nvim",
            "williamboman/mason-lspconfig.nvim",
            "tamago324/nlsp-settings.nvim",
            "ray-x/lsp_signature.nvim",
        },
    },
    {
        "williamboman/mason-lspconfig.nvim",
        cmd = { "LspInstall", "LspUninstall" },
        dependencies = { "williamboman/mason.nvim" },
    },
    {
        "tamago324/nlsp-settings.nvim",
        cmd = "LspSettings",
    },
    {
        "williamboman/mason.nvim",
        cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
        opts = {},
    },
    {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = "make install_jsregexp",
        opts = {
            history = true,
            delete_check_events = "TextChanged",
        },
        keys = {
            {
                "<tab>",
                function()
                    return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
                end,
                expr = true,
                silent = true,
                mode = "i",
            },
            {
                "<tab>",
                function()
                    require("luasnip").jump(1)
                end,
                mode = "s",
            },
            {
                "<s-tab>",
                function()
                    require("luasnip").jump(-1)
                end,
                mode = { "i", "s" },
            },
        },
        dependencies = {
            "rafamadriz/friendly-snippets",
            "saadparwaiz1/cmp_luasnip",
        },
    },
    { "folke/neodev.nvim", opts = {} },
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-nvim-lua" },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-path" },
    { "hrsh7th/cmp-emoji" },
    { "ray-x/cmp-treesitter" },
    { "saadparwaiz1/cmp_luasnip" },
    {
        "rafamadriz/friendly-snippets",
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
        end,
    },
    { "lvimuser/lsp-inlayhints.nvim", opts = {} },
    {
        "onsails/lspkind.nvim",
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
}
