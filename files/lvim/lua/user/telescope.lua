local telescope = require("telescope")
telescope.load_extension("ui-select")
telescope.load_extension("attempt")

lvim.builtin.telescope.defaults.file_ignore_patterns = {
    ".git/",
    "docs/",
    "vendor/*",
    "%.lock",
    "__pycache__/*",
    "%.ipynb",
    "node_modules/*",
    "%.jpg",
    "%.jpeg",
    "%.png",
    "%.svg",
    "%.otf",
    "%.ttf",
    "%.webp",
    ".github/",
    ".gradle/",
    ".idea/",
    ".settings/",
    ".vscode/",
    "__pycache__/",
    "build/",
    ".venv/",
    "gradle/",
    "node_modules/",
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
}

local _, actions = pcall(require, "telescope.actions")
lvim.builtin.telescope.defaults.mappings = {
    -- for input mode
    i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<Tab>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,

        ["<C-c>"] = actions.close,
        ["<esc>"] = actions.close,

        ["<C-h>"] = actions.which_key,
    },
    -- for normal mode
    n = {
        ["<C-j>"] = actions.move_selection_next,
        ["j"] = actions.move_selection_next,
        ["<Tab>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["k"] = actions.move_selection_previous,
        ["H"] = actions.move_to_top,
        ["M"] = actions.move_to_middle,
        ["L"] = actions.move_to_bottom,

        ["q"] = actions.close,
        ["<C-c>"] = actions.close,
        ["<esc>"] = actions.close,

        ["?"] = actions.which_key,
    },
}

lvim.builtin.telescope.pickers.live_grep = {
    theme = "dropdown",
}
lvim.builtin.telescope.pickers.grep_string = {
    theme = "dropdown",
}
lvim.builtin.telescope.pickers.find_files = {
    theme = "dropdown",
    previewer = false,
}
lvim.builtin.telescope.pickers.buffers = {
    theme = "dropdown",
    previewer = false,
}
lvim.builtin.telescope.pickers.planets = {
    show_pluto = true,
    show_moon = true,
}
lvim.builtin.telescope.pickers.colorscheme = {
    enable_preview = true,
}
lvim.builtin.telescope.pickers.lsp_references = {
    theme = "dropdown",
    initial_mode = "normal",
}
lvim.builtin.telescope.pickers.lsp_definitions = {
    theme = "dropdown",
    initial_mode = "normal",
}
lvim.builtin.telescope.pickers.lsp_declarations = {
    theme = "dropdown",
    initial_mode = "normal",
}
lvim.builtin.telescope.pickers.lsp_implementations = {
    theme = "dropdown",
    initial_mode = "normal",
}

lvim.builtin.telescope.defaults.path_display = nil
