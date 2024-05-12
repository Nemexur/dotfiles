return {
    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
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
                    ["ui-select"] = require("telescope.themes").get_dropdown(),
                    yanky_history = {
                        theme = "dropdown",
                        initial_mode = "normal",
                    },
                    git_worktree = {
                        theme = "dropdown",
                        initial_mode = "normal",
                    },
                    undo = {
                        initial_mode = "normal",
                    },
                },
            })
            pcall(telescope.load_extension, "fzf")
            pcall(telescope.load_extension, "ui-select")
            pcall(telescope.load_extension, "file_browser")
            pcall(telescope.load_extension, "yank_history")
            pcall(telescope.load_extension, "git_worktree")
            pcall(telescope.load_extension, "noice")
            pcall(telescope.load_extension, "undo")
        end,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-fzf-native.nvim",
            "nvim-telescope/telescope-ui-select.nvim",
            "nvim-telescope/telescope-file-browser.nvim",
            "debugloop/telescope-undo.nvim",
        },
    },
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    { "nvim-telescope/telescope-ui-select.nvim" },
    { "nvim-telescope/telescope-file-browser.nvim" },
    { "debugloop/telescope-undo.nvim" },
}
