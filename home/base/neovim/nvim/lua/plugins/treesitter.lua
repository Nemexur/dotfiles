return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        version = false,
        lazy = false,
        build = ":TSUpdate",
        cmd = { "TSUpdate", "TSInstall", "TSUninstall", "TSLog" },
        opts_extend = { "ensure_installed" },
        opts = {
            ensure_installed = {
                "bash",
                "c",
                "diff",
                "dockerfile",
                "gitcommit",
                "gitignore",
                "go",
                "gomod",
                "gosum",
                "helm",
                "html",
                "javascript",
                "jsdoc",
                "json",
                "jsonnet",
                "latex",
                "lua",
                "luadoc",
                "luap",
                "make",
                "markdown_inline",
                "markdown",
                "printf",
                "proto",
                "python",
                "query",
                "regex",
                "sql",
                "toml",
                "tsx",
                "typescript",
                "vim",
                "vimdoc",
                "xml",
                "yaml",
                "zsh",
            },
        },
        config = function(_, opts)
            local TS = require("nvim-treesitter")
            TS.setup(opts)

            local installed = {}
            for _, lang in ipairs(require("nvim-treesitter").get_installed("parsers")) do
                installed[lang] = true
            end

            local install = vim.tbl_filter(function(lang)
                return installed[lang] == nil
            end, opts.ensure_installed or {})
            TS.install(install, { summary = true })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        branch = "main",
        version = false,
        event = "VeryLazy",
        opts = {
            move = {
                keys = {
                    goto_next_start = {
                        ["]f"] = "@function.outer",
                        ["]c"] = "@class.outer",
                        ["]a"] = "@parameter.inner",
                    },
                    goto_next_end = {
                        ["]F"] = "@function.outer",
                        ["]C"] = "@class.outer",
                        ["]A"] = "@parameter.inner",
                    },
                    goto_previous_start = {
                        ["[f"] = "@function.outer",
                        ["[c"] = "@class.outer",
                        ["[a"] = "@parameter.inner",
                    },
                    goto_previous_end = {
                        ["[F"] = "@function.outer",
                        ["[C"] = "@class.outer",
                        ["[A"] = "@parameter.inner",
                    },
                },
            },
            swap = {
                swap_next = {
                    ["<leader>ns"] = "@parameter.inner",
                },
                swap_previous = {
                    ["<leader>nS"] = "@parameter.inner",
                },
            },
        },
        config = function(_, opts)
            local TS = require("nvim-treesitter-textobjects")
            TS.setup(opts)

            local function attach(buf)
                local moves = vim.tbl_get(opts, "move", "keys") or {}
                local swaps = vim.tbl_get(opts, "swap") or {}

                for method, keymaps in pairs(moves) do
                    for key, query in pairs(keymaps) do
                        local queries = type(query) == "table" and query or { query }
                        local parts = {}
                        for _, q in ipairs(queries) do
                            local part = q:gsub("@", ""):gsub("%..*", "")
                            part = part:sub(1, 1):upper() .. part:sub(2)
                            table.insert(parts, part)
                        end
                        local desc = table.concat(parts, " or ")
                        desc = (key:sub(1, 1) == "[" and "Prev " or "Next ") .. desc
                        desc = desc .. (key:sub(2, 2) == key:sub(2, 2):upper() and " End" or " Start")
                        if not (vim.wo.diff and key:find("[cC]")) then
                            vim.keymap.set({ "n", "x", "o" }, key, function()
                                require("nvim-treesitter-textobjects.move")[method](query, "textobjects")
                            end, {
                                buffer = buf,
                                desc = desc,
                                silent = true,
                            })
                        end
                    end
                end
                for method, keymaps in pairs(swaps) do
                    for key, query in pairs(keymaps) do
                        local part = method:gsub("@", ""):gsub(".*_", "")
                        local desc = "Swap Parameter " .. part:sub(1, 1):upper() .. part:sub(2)
                        vim.keymap.set({ "n" }, key, function()
                            require("nvim-treesitter-textobjects.swap")[method](query)
                        end, {
                            buffer = buf,
                            desc = desc,
                            silent = true,
                        })
                    end
                end
            end

            vim.api.nvim_create_autocmd("FileType", {
                group = vim.api.nvim_create_augroup("nemexur_treesitter_textobjects", { clear = true }),
                callback = function(ev)
                    attach(ev.buf)
                end,
            })
            vim.tbl_map(attach, vim.api.nvim_list_bufs())
        end,
    },
}
