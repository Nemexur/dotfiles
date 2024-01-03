return {
    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        lazy = true,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-fzf-native.nvim",
            "nvim-telescope/telescope-ui-select.nvim",
            "nvim-telescope/telescope-file-browser.nvim",
        },
        config = function()
            local telescope = require("telescope")
            local actions = require("telescope.actions")

            telescope.setup({
                defaults = {
                    path_display = nil,
                },
                mappings = {
                    i = {
                        ["<esc>"] = actions.close,
                    },
                    n = {
                        ["<esc>"] = actions.close,
                    },
                },
                pickers = {
                    find_files = {
                        hidden = true,
                    },
                    grep_string = {
                        only_sort_text = true,
                    },
                    live_grep = {
                        only_sort_text = true,
                    },
                    buffers = {
                        initial_mode = "normal",
                        mappings = {
                            i = {
                                ["<C-d>"] = actions.delete_buffer,
                            },
                            n = {
                                ["dd"] = actions.delete_buffer,
                            },
                        },
                    },
                },
                extensions = {
                    ["attempt"] = require("telescope.themes").get_dropdown(),
                    ["ui-select"] = require("telescope.themes").get_dropdown(),
                    ["yanky_history"] = require("telescope.themes").get_dropdown(),
                    ["git_worktree"] = require("telescope.themes").get_dropdown(),
                },
            })
            pcall(telescope.load_extension, "fzf")
            pcall(telescope.load_extension, "ui-select")
            pcall(telescope.load_extension, "macros")
            pcall(telescope.load_extension, "file_browser")
            pcall(telescope.load_extension, "yank_history")
            pcall(telescope.load_extension, "git_worktree")
        end,
    },
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        lazy = true,
    },
    {
        "nvim-telescope/telescope-ui-select.nvim",
        lazy = true,
    },
    {
        "nvim-telescope/telescope-file-browser.nvim",
        lazy = true,
    },
}
