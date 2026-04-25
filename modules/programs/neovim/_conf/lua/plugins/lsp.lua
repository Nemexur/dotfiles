return {
    {
        "saghen/blink.cmp",
        event = { "BufReadPost", "BufNewFile", "BufWritePre" },
        version = "1.*",
        enabled = function()
            return not vim.tbl_contains({ "tex" }, vim.bo.filetype) and vim.bo.filetype ~= "prompt"
        end,
        dependencies = {
            "saghen/blink.compat",
            { "nvim-mini/mini.icons", version = false },
            { "mikavilpas/blink-ripgrep.nvim", version = "*" },
            { "marcoSven/blink-cmp-yanky" },
        },
        config = function()
            local blink = require("blink.cmp")
            blink.setup({
                fuzzy = {
                    implementation = "prefer_rust_with_warning",
                },
                snippets = {
                    preset = "mini_snippets",
                    expand = function(snippet)
                        local insert = MiniSnippets.config.expand.insert or MiniSnippets.default_insert
                        insert({ body = snippet })
                        blink.resubscribe()
                    end,
                    active = function()
                        return MiniSnippets.session.get(false) ~= nil
                    end,
                    jump = function(direction)
                        local is_active = MiniSnippets.session.get(false) ~= nil
                        if is_active then
                            MiniSnippets.session.jump(direction == -1 and "prev" or "next")
                        end
                    end,
                },
                keymap = {
                    preset = "default",
                    ["<C-g>"] = {
                        function(cmp)
                            cmp.show({ providers = { "ripgrep", "lsp", "path", "buffer" } })
                        end,
                    },
                },
                appearance = {
                    use_nvim_cmp_as_default = true,
                    nerd_font_variant = "mono",
                },
                sources = {
                    default = { "lazydev", "lsp", "path", "buffer", "dadbod", "yank" },
                    providers = {
                        lazydev = {
                            name = "LazyDev",
                            module = "lazydev.integrations.blink",
                            score_offset = 100,
                        },
                        dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
                        ripgrep = {
                            name = "Ripgrep",
                            module = "blink-ripgrep",
                            opts = {},
                        },
                        yank = {
                            name = "yank",
                            module = "blink-yanky",
                            opts = {
                                minLength = 5,
                                onlyCurrentFiletype = true,
                                trigger_characters = { '"' },
                                kind_icon = "󰅍",
                            },
                        },
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
                                    text = function(ctx)
                                        local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
                                        return kind_icon
                                    end,
                                    -- (optional) use highlights from mini.icons
                                    highlight = function(ctx)
                                        local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                                        return hl
                                    end,
                                },
                                kind = {
                                    -- (optional) use highlights from mini.icons
                                    highlight = function(ctx)
                                        local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                                        return hl
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
                    foldingRange = { dynamicRegistration = false, lineFoldingOnly = true },
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
                { path = "mini.snippets", words = { "MiniSnippets" } },
            },
        },
    },
    {
        "nvim-mini/mini.snippets",
        event = "InsertEnter",
        dependencies = { "rafamadriz/friendly-snippets" },
        opts = function()
            local mini_snippets = require("mini.snippets")
            return {
                snippets = { mini_snippets.gen_loader.from_lang() },
            }
        end,
    },
}
