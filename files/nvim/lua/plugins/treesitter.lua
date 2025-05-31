return {
    {
        "nvim-treesitter/nvim-treesitter",
        event = "VeryLazy",
        build = ":TSUpdate",
        main = "nvim-treesitter.configs",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
            "JoosepAlviste/nvim-ts-context-commentstring",
            "nvim-treesitter/nvim-treesitter-context",
        },
        opts = {
            sync_install = false,
            auto_install = false,
            ignore_install = {},
            ensure_installed = {
                "bash",
                "json",
                "lua",
                "python",
                "yaml",
                "go",
                "latex",
                "make",
                "markdown",
                "markdown_inline",
                "sql",
                "toml",
                "jsonnet",
            },
            indent = { enable = true, disable = { "ruby" } },
            autotag = { enable = true },
            matchup = { enable = true },
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = { "ruby" },
            },
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true,
                    selection_modes = {
                        ["@parameter.outer"] = "v",
                        ["@function.outer"] = "V",
                        ["@class.outer"] = "<c-v>",
                    },
                    keymaps = {
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                        ["as"] = "@class.outer",
                        ["is"] = "@class.inner",
                        ["ac"] = "@call.outer",
                        ["ic"] = "@call.inner",
                        ["aa"] = "@parameter.outer",
                        ["ia"] = "@parameter.inner",
                        ["al"] = "@loop.outer",
                        ["il"] = "@loop.inner",
                        ["ai"] = "@conditional.outer",
                        ["ii"] = "@conditional.inner",
                        ["a/"] = "@comment.outer",
                        ["i/"] = "@comment.inner",
                        ["ab"] = "@block.outer",
                        ["ib"] = "@block.inner",
                        ["aA"] = "@attribute.outer",
                        ["iA"] = "@attribute.inner",
                        ["aF"] = "@frame.outer",
                        ["iF"] = "@frame.inner",
                    },
                },
                move = {
                    enable = true,
                    set_jumps = true,
                    goto_next_start = { ["]f"] = "@function.outer", ["]s"] = "@class.outer" },
                    goto_next_end = {
                        ["]F"] = "@function.outer",
                        ["]S"] = "@class.outer",
                    },
                    goto_previous_start = { ["[f"] = "@function.outer", ["[s"] = "@class.outer" },
                    goto_previous_end = { ["[F"] = "@function.outer", ["[S"] = "@class.outer" },
                },
                swap = {
                    enable = true,
                    swap_next = {
                        ["<leader>ns"] = "@parameter.inner",
                    },
                    swap_previous = {
                        ["<leader>nS"] = "@parameter.inner",
                    },
                },
                lsp_interop = {
                    enable = true,
                    floating_preview_opts = {
                        border = "rounded",
                    },
                    peek_definition_code = {
                        ["<leader>lf"] = "@function.outer",
                        ["<leader>ls"] = "@class.outer",
                    },
                },
            },
        },
    },
    {
        "JoosepAlviste/nvim-ts-context-commentstring",
        opts = { enable_autocmd = false },
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        opts = { max_lines = 1 },
        keys = {
            {
                "[c",
                "<cmd>lua require('treesitter-context').go_to_context(vim.v.count1)<cr>",
                mode = { "n", "v" },
                desc = "Goto Context",
            },
        },
    },
}
