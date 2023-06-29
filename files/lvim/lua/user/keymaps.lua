-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"

-- Convenient keymaps
local keymaps = {
    normal_mode = {
        ["n"] = "nzzzv",
        ["N"] = "Nzzzv",
        ["<C-s>"] = ":w<cr>",
        ["<C-d>"] = "<C-d>zz",
        ["<C-u>"] = "<C-u>zz",
        ["<C-c>"] = ":qa!<cr>",
        ["<C-k>"] = "<cmd>BufferKill<cr>",
        ["<C-p>"] = "<cmd>YankyRingHistory<cr>",
        ["<C-w>"] = "<cmd>lua require('hop').hint_patterns()<cr>",
        ["s"] = "<cmd>lua require('substitute').operator()<cr>",
        ["ss"] = "<cmd>lua require('substitute').line()<cr>",
        ["S"] = "<cmd>lua require('substitute').eol()<cr>",
        ["sx"] = "<cmd>lua require('substitute.exchange').operator()<cr>",
        ["sxx"] = "<cmd>lua require('substitute.exchange').line()<cr>",
        ["sxc"] = "<cmd>lua require('substitute.exchange').cancel()<cr>",
        ["gpd"] = "<cmd>lua require('goto-preview').goto_preview_definition()<cr>",
        ["gpi"] = "<cmd>lua require('goto-preview').goto_preview_implementation()<cr>",
        ["gP"] = "<cmd>lua require('goto-preview').close_all_win()<cr>",
        ["f"] = "<cmd>lua require('hop').hint_char1({ direction = require('hop.hint').HintDirection.AFTER_CURSOR, current_line_only = true })<cr>",
        ["F"] = "<cmd>lua require('hop').hint_char1({ direction = require('hop.hint').HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>",
        ["t"] = "<cmd>lua require('hop').hint_char1({ direction = require('hop.hint').HintDirection.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })<cr>",
        ["T"] = "<cmd>lua require('hop').hint_char1({ direction = require('hop.hint').HintDirection.BEFORE_CURSOR, current_line_only = true, hint_offset = -1 })<cr>",
        ["p"] = "<Plug>(YankyPutAfter)",
        ["P"] = "<Plug>(YankyPutBefore)",
    },
    visual_mode = {
        ["s"] = "<cmd>lua require('substitute').visual()<cr>",
        ["X"] = "<cmd>lua require('substitute.exchange').visual()<cr>",
        ["J"] = ":m '>+1<cr>gv=gv",
        ["K"] = ":m '<-2<cr>gv=gv",
    },
    insert_mode = {},
    command_mode = {},
}
for mode, mappings in pairs(keymaps) do
    for k, v in pairs(mappings) do
        lvim.keys[mode][k] = v
    end
end

local which_key_mappings = {
    ["C"] = { "<cmd>BufferKill<cr>", "Close Buffer" },
    ["u"] = { "<C-r>", "Redo" },
    ["o"] = { "o<esc>", "New Line" },
    ["a"] = {
        name = "Attempt Buffer",
        l = { "<cmd>Telescope attempt<cr>", "Select Script" },
        n = { "<cmd>lua require('attempt').new_select()<cr>", "Select Lang" },
        r = { "<cmd>lua require('attempt').run()<cr>", "Run Script" },
        d = { "<cmd>lua require('attempt').delete_buf()<cr>", "Delete Script" },
        c = { "<cmd>lua require('attempt').delete_buf()<cr>", "Rename Script" },
    },
    ["r"] = {
        name = "Spectre",
        r = { "<cmd>lua require('spectre').open()<cr>", "Replace" },
        w = { "<cmd>lua require('spectre').open_visual({select_word=true})<cr>", "Replace Word" },
        f = { "<cmd>lua require('spectre').open_file_search()<cr>", "Replace Buffer" },
    },
    ["w"] = {
        name = "Windows",
        m = { "<cmd>FocusMaxOrEqual<cr>", "Toggle Maximized" },
        f = { "<cmd>FocusToggle<cr>", "Toggle Focus" },
        s = { "<C-w>s", "Horizontal" },
        v = { "<C-w>v", "Vertical" },
        c = { "<C-w>q", "Close" },
        q = { "<C-w>q", "Close" },
        h = { "<C-w>h", "Go Left" },
        j = { "<C-w>j", "Go Right" },
        k = { "<C-w>k", "Go Up" },
        l = { "<C-w>l", "Go Down" },
        w = { "<cmd>ToggleWrapMode<cr>", "Toggle word wrap mode" },
    },
    ["i"] = {
        name = "Sessions",
        r = { "<cmd>lua require('persistence').load()<cr>", "Resore session" },
        l = { "<cmd>lua require('persistence').load({ last = true })<cr>", "Restore last session" },
        Q = { "<cmd>lua require('persistence').stop()<cr>", "Quit without saving session" },
    },
    ["q"] = {
        name = "Quit",
        q = { ":qa<cr>", "Quit all buffers" },
        a = { ":wqa<cr>", "Save all buffers and quit" },
        f = { ":qa!<cr>", "Force quit all buffers" },
    },
    ["n"] = {
        name = "Neogen",
        c = { "<cmd>lua require('neogen').generate({ type = 'class' })<cr>", "Class Doc" },
        f = { "<cmd>lua require('neogen').generate({ type = 'func' })<cr>", "Function Doc" },
        t = { "<cmd>lua require('neogen').generate({ type = 'type' })<cr>", "Type Doc" },
    },
    ["P"] = {
        name = "Plugins",
        i = { "<cmd>Lazy install<cr>", "Install" },
        s = { "<cmd>Lazy sync<cr>", "Sync" },
        S = { "<cmd>Lazy clear<cr>", "Status" },
        c = { "<cmd>Lazy clean<cr>", "Clean" },
        u = { "<cmd>Lazy update<cr>", "Update" },
        p = { "<cmd>Lazy profile<cr>", "Profile" },
        l = { "<cmd>Lazy log<cr>", "Log" },
        d = { "<cmd>Lazy debug<cr>", "Debug" },
    },
    ["p"] = {},
}
for k, v in pairs(which_key_mappings) do
    lvim.builtin.which_key.mappings[k] = v
end

-- Extra mappings
local extra_mappings = {
    ["L"] = {
        ["w"] = { ":wa<cr>", "Save all buffers" },
    },
    ["b"] = {
        ["k"] = { "<cmd>BufferKill<cr>", "Close buffer" },
    },
    ["l"] = {
        ["R"] = { "<cmd>LspRestart<cr>", "Restart LSP in buffer" },
    },
    ["s"] = {
        ["u"] = { "<cmd>UndotreeToggle<cr>", "Toggle undotree" },
    },
}
for k, maps in pairs(extra_mappings) do
    for v, cmd in pairs(maps) do
        lvim.builtin.which_key.mappings[k][v] = cmd
    end
end
