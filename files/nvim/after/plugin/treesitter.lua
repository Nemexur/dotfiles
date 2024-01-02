local treesitter_configs_ok, treesitter_configs = pcall(require, "nvim-treesitter.configs")
if not treesitter_configs_ok then
    return
end

treesitter_configs.setup({
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
