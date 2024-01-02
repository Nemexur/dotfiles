local telescope_ok, telescope = pcall(require, "telescope")
if not telescope_ok then
    return
end

local actions_ok, actions = pcall(require, "telescope.actions")
if not actions_ok then
    return
end

local file_ignore_patterns = {
    "%.jpg",
    "%.jpeg",
    "%.png",
    "%.svg",
    "%.otf",
    "%.ttf",
    "%.webp",
    "%.pdb",
    "%.dll",
    "%.exe",
    "%.cache",
    "%.ico",
    "%.pdf",
    "%.dylib",
    "%.jar",
    "%.docx",
    "%.plist",
    "%.met",
    "%.mp4",
    "%.mkv",
    "%.rar",
    "%.zip",
    "%.7z",
    "%.tar",
    "%.bz2",
    "%.epub",
    "%.flac",
    "%.tar.gz",
    ".git/",
    ".github/",
    ".gradle/",
    ".idea/",
    ".settings/",
    ".vscode/",
    ".venv/",
    "build/",
    "gradle/",
    "vendor/",
    "node_modules/",
    "__pycache__/",
}

telescope.setup({
    defaults = {
        vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--hidden",
            "--glob=!.git/",
        },
        path_display = nil,
        file_ignore_patterns = file_ignore_patterns,
        mappings = {
            i = {
                ["<Tab>"] = actions.move_selection_next,
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
                ["<C-n>"] = actions.cycle_history_next,
                ["<C-p>"] = actions.cycle_history_prev,
                ["<C-d>"] = actions.delete_buffer,
                ["<C-c>"] = actions.close,
            },
            n = {
                ["<Tab>"] = actions.move_selection_next,
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
                ["j"] = actions.move_selection_next,
                ["k"] = actions.move_selection_previous,
                ["H"] = actions.move_to_top,
                ["M"] = actions.move_to_middle,
                ["L"] = actions.move_to_bottom,
                ["?"] = actions.which_key,
                ["q"] = actions.close,
                ["<C-c>"] = actions.close,
                ["<C-d>"] = actions.delete_buffer,
                ["<C-h>"] = actions.select_horizontal,
                ["<C-v>"] = actions.select_vertical,
            },
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
pcall(telescope.load_extension, "attempt")
pcall(telescope.load_extension, "macros")
pcall(telescope.load_extension, "file_browser")
pcall(telescope.load_extension, "yank_history")
pcall(telescope.load_extension, "git_worktree")
