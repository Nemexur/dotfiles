-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"

-- Convenient keymaps
local keymaps = {
    normal_mode = {
        ["<C-s>"] = ":w<cr>",
        ["s"] = "<cmd>lua require('substitute').operator()<cr>",
        ["ss"] = "<cmd>lua require('substitute').line()<cr>",
        ["S"] = "<cmd>lua require('substitute').eol()<cr>",
        ["sx"] = "<cmd>lua require('substitute.exchange').operator()<cr>",
        ["sxx"] = "<cmd>lua require('substitute.exchange').line()<cr>",
        ["sxc"] = "<cmd>lua require('substitute.exchange').cancel()<cr>",
        ["gpd"] = "<cmd>lua require('goto-preview').goto_preview_definition()<cr>",
        ["gpi"] = "<cmd>lua require('goto-preview').goto_preview_implementation()<cr>",
        ["gP"] = "<cmd>lua require('goto-preview').close_all_win()<cr>",
        [";"] = "<Plug>(leap-forward-to)",
        ["g;"] = "<Plug>(leap-backward-to)",
    },
    visual_mode = {
        ["s"] = "<cmd>lua require('substitute').visual()<cr>",
        ["X"] = "<cmd>lua require('substitute.exchange').visual()<cr>",
    },
    insert_mode = {},
    command_mode = {},
}
if vim.g.neovide then
    keymaps.normal_mode["<D-s>"] = ":w<CR>"
    keymaps.normal_mode["<D-v>"] = '"+Pl'
    keymaps.visual_mode["<D-c>"] = '"+y'
    keymaps.visual_mode["<D-v>"] = '"+Pl'
    keymaps.insert_mode["<D-v>"] = '<ESC>l"+Pli'
    keymaps.command_mode["<D-v>"] = '<C-R>+'
    -- Allow clipboard copy paste in neovim
    local opts = { noremap = true, silent = true }
    vim.api.nvim_set_keymap("", "<D-v>", "+p<CR>", opts)
    vim.api.nvim_set_keymap("!", "<D-v>", "<C-R>+", opts)
    vim.api.nvim_set_keymap("t", "<D-v>", "<C-R>+", opts)
    vim.api.nvim_set_keymap("v", "<D-v>", "<C-R>+", opts)
end

for mode, mappings in pairs(keymaps) do
    for k, v in pairs(mappings) do
        lvim.keys[mode][k] = v
    end
end

local which_key_mappings = {
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
    },
    ["i"] = {
        name = "Sessions",
        r = { "<cmd>lua require('persistence').load()<cr>", "Resore session" },
        l = { "<cmd>lua require('persistence').load({ last = true })<cr>", "Restore last session" },
        Q = { "<cmd>lua require('persistence').stop()<cr>", "Quit without saving session" },
    },
    ["q"] = {
        name = "Quit",
        q = { ":q<cr>", "Quit a buffer" },
        w = { ":wq<cr>", "Save a buffer and quit" },
        a = { ":wqa<cr>", "Save all buffers and quit" },
    },
}
for k, v in pairs(which_key_mappings) do
    lvim.builtin.which_key.mappings[k] = v
end

-- Extra mappings
lvim.builtin.which_key.mappings["L"]["w"] = { ":wa<cr>", "Save all buffers" }
