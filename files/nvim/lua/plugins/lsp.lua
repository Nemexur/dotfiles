return {
    {
        "saghen/blink.cmp",
        event = { "BufReadPost", "BufNewFile", "BufWritePre" },
        version = "1.*",
        enabled = function()
            return not vim.tbl_contains({ "tex" }, vim.bo.filetype) and vim.bo.filetype ~= "prompt"
        end,
        dependencies = {
            "L3MON4D3/LuaSnip",
            "rafamadriz/friendly-snippets",
            "saghen/blink.compat",
        },
        config = function()
            local blink = require("blink.cmp")
            blink.setup({
                snippets = { preset = "luasnip" },
                keymap = { preset = "default" },
                appearance = {
                    use_nvim_cmp_as_default = true,
                    nerd_font_variant = "mono",
                },
                sources = {
                    default = { "lazydev", "lsp", "path", "snippets", "buffer", "dadbod" },
                    providers = {
                        lazydev = {
                            name = "LazyDev",
                            module = "lazydev.integrations.blink",
                            score_offset = 100,
                        },
                        dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
                    },
                },
                cmdline = {
                    enabled = false,
                },
                completion = {
                    accept = {
                        auto_brackets = {
                            enabled = true,
                        },
                    },
                    menu = {
                        border = "single",
                        draw = {
                            components = {
                                kind_icon = {
                                    ellipsis = false,
                                    text = function(ctx)
                                        return require("lspkind").symbolic(ctx.kind, {
                                            mode = "symbol",
                                        })
                                    end,
                                },
                            },
                            columns = {
                                { "label", "label_description", gap = 1 },
                                { "kind_icon", "kind", gap = 1 },
                            },
                            treesitter = { "lsp" },
                        },
                    },
                    documentation = {
                        auto_show = true,
                        auto_show_delay_ms = 200,
                        window = { border = "single" },
                    },
                    ghost_text = { enabled = true },
                },
            })
            local capabilities = {
                textDocument = {
                    foldingRange = {
                        dynamicRegistration = false,
                        lineFoldingOnly = true,
                    },
                },
            }
            vim.lsp.config("*", { capabilities = blink.get_lsp_capabilities(capabilities, true) })
        end,
    },
    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            library = {
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                { path = "snacks.nvim", words = { "Snacks" } },
                { path = "lazy.nvim", words = { "LazyVim" } },
            },
        },
    },
    {
        "williamboman/mason.nvim",
        event = { "BufReadPost", "BufNewFile", "BufWritePre" },
        cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
        dependencies = { "saghen/blink.cmp" },
        config = function()
            require("mason").setup()
            for _, f in pairs(vim.api.nvim_get_runtime_file("lsp/*.lua", true)) do
                local name = vim.fn.fnamemodify(f, ":t:r")
                local cmd = dofile(f).cmd[1]
                if vim.fn.executable(cmd) == 0 then
                    vim.cmd("MasonInstall " .. name)
                end
                vim.lsp.enable(name)
            end
        end,
    },
    {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = "make install_jsregexp",
        dependencies = {
            "rafamadriz/friendly-snippets",
        },
        opts = {
            history = true,
            delete_check_events = "TextChanged",
        },
    },
    {
        "rafamadriz/friendly-snippets",
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
            require("luasnip.loaders.from_lua").lazy_load()
            require("luasnip.loaders.from_snipmate").lazy_load()
        end,
    },
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
