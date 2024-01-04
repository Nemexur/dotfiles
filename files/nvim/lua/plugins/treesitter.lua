return {
    {
        "nvim-treesitter/nvim-treesitter",
        cmd = {
            "TSInstall",
            "TSUninstall",
            "TSUpdate",
            "TSUpdateSync",
            "TSInstallInfo",
            "TSInstallSync",
            "TSInstallFromGrammar",
        },
        event = { "VeryLazy", "BufReadPost", "BufNewFile", "BufWritePre" },
        dependencies = {
            { "nvim-treesitter/nvim-treesitter-textobjects" },
        },
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "bash",
                    "c",
                    "javascript",
                    "json",
                    "lua",
                    "python",
                    "typescript",
                    "tsx",
                    "css",
                    "rust",
                    "java",
                    "yaml",
                    "go",
                    "latex",
                    "make",
                    "markdown",
                    "sql",
                    "toml",
                },
                autotag = {
                    enable = true,
                },
                matchup = {
                    enable = true,
                },
                auto_install = false,
                highlight = {
                    enable = true,
                },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "<C-space>",
                        node_incremental = "<C-space>",
                        scope_incremental = false,
                        node_decremental = "<bs>",
                    },
                },
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true,
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
                        goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer" },
                        goto_next_end = {
                            ["]F"] = "@function.outer",
                            ["]C"] = "@class.outer",
                        },
                        goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer" },
                        goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer" },
                    },
                    swap = {
                        enable = true,
                        swap_next = {
                            ["<leader>s"] = "@parameter.inner",
                        },
                        swap_previous = {
                            ["<leader>S"] = "@parameter.inner",
                        },
                    },
                },
            })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        event = { "VeryLazy", "BufReadPost", "BufNewFile", "BufWritePre" },
        config = function()
            -- When in diff mode, we want to use the default
            -- vim text objects c & C instead of the treesitter ones.
            local move = require("nvim-treesitter.textobjects.move") ---@type table<string,fun(...)>
            local configs = require("nvim-treesitter.configs")
            for name, fn in pairs(move) do
                if name:find("goto") == 1 then
                    move[name] = function(q, ...)
                        if vim.wo.diff then
                            local config = configs.get_module("textobjects.move")[name] ---@type table<string,string>
                            for key, query in pairs(config or {}) do
                                if q == query and key:find("[%]%[][cC]") then
                                    vim.cmd("normal! " .. key)
                                    return
                                end
                            end
                        end
                        return fn(q, ...)
                    end
                end
            end
        end,
    },
    {
        "JoosepAlviste/nvim-ts-context-commentstring",
        event = { "VeryLazy", "BufReadPost", "BufNewFile", "BufWritePre" },
        opts = {
            enable_autocmd = false,
        },
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        opts = { max_lines = 1 },
        event = { "VeryLazy", "BufReadPost", "BufNewFile", "BufWritePre" },
    },
}
