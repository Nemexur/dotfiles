-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"

-- Convenient keymaps
local keymaps = {
    normal_mode = {
        ["j"] = "gj",
        ["k"] = "gk",
        ["n"] = "nzzzv",
        ["N"] = "Nzzzv",
        ["<C-d>"] = "<C-d>zz",
        ["<C-u>"] = "<C-u>zz",
        ["<C-p>"] = "<cmd>YankyRingHistory<cr>",
        -- ["s"] = "<cmd>lua require('substitute').operator()<cr>",
        -- ["ss"] = "<cmd>lua require('substitute').line()<cr>",
        -- ["S"] = "<cmd>lua require('substitute').eol()<cr>",
        -- ["sx"] = "<cmd>lua require('substitute.exchange').operator()<cr>",
        -- ["sxx"] = "<cmd>lua require('substitute.exchange').line()<cr>",
        -- ["sxc"] = "<cmd>lua require('substitute.exchange').cancel()<cr>",
        ["gpd"] = "<cmd>lua require('goto-preview').goto_preview_definition()<cr>",
        ["gpi"] = "<cmd>lua require('goto-preview').goto_preview_implementation()<cr>",
        ["gP"] = "<cmd>lua require('goto-preview').close_all_win()<cr>",
        ["p"] = "<Plug>(YankyPutAfter)",
        ["P"] = "<Plug>(YankyPutBefore)",
        ["[c"] = "<cmd>lua require('treesitter-context').go_to_context()<cr>",
    },
    visual_mode = {
        ["j"] = "gj",
        ["k"] = "gk",
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
    ["z"] = { "zz", "Center buffer" },
    ["o"] = {
        name = "Obsidian",
        f = { "<cmd>ObsidianFollowLink<cr>", "Follow link" },
        n = { "<cmd>ObsidianNew<cr>", "New file" },
        s = { "<cmd>ObsidianQuickSwitch<cr>", "Quick Switch" },
        o = { string.format("<cmd>edit %s<cr>", os.getenv("SECOND_BRAIN")), "Open Obsidian" },
    },
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
        o = { "<cmd>Lazy<cr>", "Open" },
        i = { "<cmd>Lazy install<cr>", "Install" },
        s = { "<cmd>Lazy sync<cr>", "Sync" },
        S = { "<cmd>Lazy clear<cr>", "Status" },
        c = { "<cmd>Lazy clean<cr>", "Clean" },
        u = { "<cmd>Lazy update<cr>", "Update" },
        p = { "<cmd>Lazy profile<cr>", "Profile" },
        l = { "<cmd>Lazy log<cr>", "Log" },
        d = { "<cmd>Lazy debug<cr>", "Debug" },
    },
    ["f"] = {
        name = "Files",
        f = {
            function()
                require("lvim.core.telescope.custom-finders").find_project_files({ previewer = false })
            end,
            "Find File",
        },
        b = { "<cmd>Telescope file_browser<cr>", "File Browser" },
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
        f = {},
        k = { "<cmd>BufferKill<cr>", "Close buffer" },
        b = { "<cmd>Telescope buffers previewer=false<cr>", "Find" },
        p = { "<cmd>BufferLineCyclePrev<cr>", "Previous" },
    },
    ["l"] = {
        ["R"] = { "<cmd>LspRestart<cr>", "Restart LSP in buffer" },
    },
    ["s"] = {
        ["u"] = { "<cmd>UndotreeToggle<cr>", "Toggle undotree" },
        ["F"] = { "<cmd>Telescope find_files hidden=true no_ignore=true<cr>", "Find File (all)" },
    },
}
for k, maps in pairs(extra_mappings) do
    for v, cmd in pairs(maps) do
        lvim.builtin.which_key.mappings[k][v] = cmd
    end
end
