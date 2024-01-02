local keymaps = {
    v = {
        ["j"] = "gj",
        ["k"] = "gk",
        ["s"] = "<cmd>lua require('substitute').visual()<cr>",
        ["X"] = "<cmd>lua require('substitute.exchange').visual()<cr>",
        ["J"] = ":m '>+1<cr>gv=gv",
        ["K"] = ":m '<-2<cr>gv=gv",
    },
    n = {
        ["j"] = "gj",
        ["k"] = "gk",
        ["n"] = "nzzzv",
        ["N"] = "Nzzzv",
        ["<C-d>"] = "<C-d>zz",
        ["<C-u>"] = "<C-u>zz",
        ["<C-p>"] = "<cmd>YankyRingHistory<cr>",
        ["p"] = "<Plug>(YankyPutAfter)",
        ["P"] = "<Plug>(YankyPutBefore)",
        ["<C-e>"] = "<cmd>lua require('harpoon').ui:toggle_quick_menu(require('harpoon'):list())<cr>",
        ["<C-h>"] = "<cmd>lua require('harpoon'):list():select(1)<cr>",
        ["<C-j>"] = "<cmd>lua require('harpoon'):list():select(2)<cr>",
    },
}
for mode, mappings in pairs(keymaps) do
    for k, v in pairs(mappings) do
        vim.keymap.set(mode, k, v, { noremap = true, silent = true })
    end
end

local which_key_ok, which_key = pcall(require, "which-key")
if not which_key_ok then
    return
end

local opts = {
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true, -- use `nowait` when creating keymaps
}
local vopts = {
    mode = "v", -- VISUAL mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
    c = { "<cmd>lua require('treesitter-context').go_to_context(vim.v.count1)<cr>", "Goto Context" },
    u = { "<C-r>", "Redo" },
    e = { "<cmd>Oil<cr>", "Open parent directory" },
    h = { "<cmd>lua require('harpoon'):list():append()<CR>", "Harpoon append" },
    o = {
        name = "Obsidian",
        f = { "<cmd>ObsidianFollowLink<cr>", "Follow link" },
        n = { "<cmd>ObsidianNew<cr>", "New file" },
        s = { "<cmd>ObsidianQuickSwitch<cr>", "Quick Switch" },
        o = { string.format("<cmd>edit %s<cr>", os.getenv("SECOND_BRAIN")), "Open Obsidian" },
    },
    p = {
        name = "Persistence",
        r = { "<cmd>lua require('persistence').load()<cr>", "Resore session" },
        l = { "<cmd>lua require('persistence').load({ last = true })<cr>", "Restore last session" },
        Q = { "<cmd>lua require('persistence').stop()<cr>", "Quit without saving session" },
    },
    a = {
        name = "Attempt Buffer",
        s = { "<cmd>Telescope attempt<cr>", "Select Script" },
        l = { "<cmd>lua require('attempt').new_select()<cr>", "Select Lang" },
        r = { "<cmd>lua require('attempt').run()<cr>", "Run Script" },
        d = { "<cmd>lua require('attempt').delete_buf()<cr>", "Delete Script" },
        c = { "<cmd>lua require('attempt').delete_buf()<cr>", "Rename Script" },
    },
    r = {
        name = "Spectre",
        r = { "<cmd>lua require('spectre').open()<cr>", "Replace" },
        w = { "<cmd>lua require('spectre').open_visual({select_word=true})<cr>", "Replace Word" },
        b = { "<cmd>lua require('spectre').open_file_search()<cr>", "Replace Buffer" },
        s = { "<cmd>lua require('ssr').open()<cr>", "Structrual Search" },
        n = { ":IncRename ", "Incremental Rename" },
    },
    w = {
        name = "Windows",
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
    b = {
        name = "Buffers",
        b = { "<cmd>Telescope buffers previewer=false theme=dropdown<cr>", "Find" },
        p = { "<cmd>bprevious<cr>", "Previous" },
        n = { "<cmd>bnext<cr>", "Next" },
        W = { "<cmd>noautocmd w<cr>", "Save without formatting (noautocmd)" },
        c = { "<cmd>bd<cr>", "Close buffer" },
    },
    q = {
        name = "Quit",
        q = { ":qa<cr>", "Quit all buffers" },
        a = { ":wqa<cr>", "Save all buffers and quit" },
        f = { ":qa!<cr>", "Force quit all buffers" },
    },
    g = {
        name = "Git",
        l = { "<cmd>LazyGit<cr>", "LazyGit" },
        n = { "<cmd>Neogit<cr>", "NeoGit" },
        w = { "<cmd>Telescope git_worktree theme=dropdown<cr>", "Worktree" },
    },
    f = {
        name = "Find",
        b = { "<cmd>Telescope git_branches theme=dropdown<cr>", "Checkout branch" },
        c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
        f = { "<cmd>Telescope find_files hidden=true previewer=false theme=dropdown<cr>", "Find File" },
        h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
        H = { "<cmd>Telescope highlights<cr>", "Find highlight groups" },
        M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
        r = { "<cmd>Telescope oldfiles theme=dropdown<cr>", "Open Recent File" },
        t = { "<cmd>Telescope live_grep<cr>", "Text" },
        k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
        C = { "<cmd>Telescope commands<cr>", "Commands" },
        l = { "<cmd>Telescope resume theme=dropdown<cr>", "Resume last search" },
    },
    l = {
        name = "LSP",
        a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
        b = { "<cmd>Telescope diagnostics bufnr=0 theme=get_ivy<cr>", "Buffer Diagnostics" },
        w = { "<cmd>Telescope diagnostics<cr>", "Diagnostics" },
        f = { "<cmd>lua vim.lsp.buf.format({async = false, timeout_ms = 10000})<cr>", "Format" },
        i = { "<cmd>LspInfo<cr>", "Info" },
        I = { "<cmd>Mason<cr>", "Mason Info" },
        n = { "<cmd>lua vim.diagnostic.goto_next()<cr>", "Next Diagnostic" },
        p = { "<cmd>lua vim.diagnostic.goto_prev()<cr>", "Prev Diagnostic" },
        l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
        q = { "<cmd>lua vim.diagnostic.setloclist()<cr>", "Quickfix" },
        r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
        s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
        S = { "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "Workspace Symbols" },
        e = { "<cmd>Telescope quickfix<cr>", "Telescope Quickfix" },
        R = { "<cmd>LspRestart<cr>", "Restart LSP in buffer" },
    },
    n = {
        name = "Neogen",
        c = { "<cmd>lua require('neogen').generate({ type = 'class' })<cr>", "Class Doc" },
        f = { "<cmd>lua require('neogen').generate({ type = 'func' })<cr>", "Function Doc" },
        t = { "<cmd>lua require('neogen').generate({ type = 'type' })<cr>", "Type Doc" },
    },
    P = {
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
}

local vmappings = {
    ["/"] = { "<Plug>(comment_toggle_linewise_visual)", "Comment toggle linewise (visual)" },
    l = {
        name = "LSP",
        a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
    },
}

which_key.register(mappings, opts)
which_key.register(vmappings, vopts)
