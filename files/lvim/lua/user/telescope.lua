lvim.builtin.telescope.defaults.file_ignore_patterns = {
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

local actions = require("telescope.actions")
lvim.builtin.telescope.defaults.mappings = {
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
        ["j"]     = actions.move_selection_next,
        ["k"]     = actions.move_selection_previous,
        ["H"]     = actions.move_to_top,
        ["M"]     = actions.move_to_middle,
        ["L"]     = actions.move_to_bottom,
        ["?"]     = actions.which_key,
        ["q"]     = actions.close,
        ["<C-c>"] = actions.close,
        ["<C-d>"] = actions.delete_buffer,
        ["<C-h>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
    },
}
lvim.builtin.telescope.pickers.buffers.initial_mode = "normal"
lvim.builtin.telescope.defaults.path_display = nil
lvim.builtin.telescope.on_config_done = function(t)
    pcall(t.load_extension, "ui-select")
    pcall(t.load_extension, "attempt")
    pcall(t.load_extension, "macros")
    pcall(t.load_extension, "file_browser")
end
