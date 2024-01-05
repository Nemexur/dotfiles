local function map(mode, lhs, rhs, opts)
    local keys = require("lazy.core.handler").handlers.keys
    local modes = type(mode) == "string" and { mode } or mode

    modes = vim.tbl_filter(function(m)
        return not (keys.have and keys:have(lhs, m))
    end, modes)

    -- do not create the keymap if a lazy keys handler exists
    if #modes > 0 then
        opts = opts or {}
        opts.silent = opts.silent ~= false
        if opts.remap and not vim.g.vscode then
            opts.remap = nil
        end
        vim.keymap.set(modes, lhs, rhs, opts)
    end
end

-- Better up/down
map({ "n", "x", "v" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x", "v" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x", "v" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map({ "n", "x", "v" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Visual Move
map("v", "J", ":m '>+1<cr>gv=gv", { desc = "Move visual down" })
map("v", "K", ":m '<-2<cr>gv=gv", { desc = "Move visual up" })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next search result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev search result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- Save file
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- Better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Sane C-d, C-u
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- Harpoon
map(
    "n",
    "<C-e>",
    "<cmd>lua require('harpoon').ui:toggle_quick_menu(require('harpoon'):list())<cr>",
    { desc = "Harpoon List" }
)

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
    k = { "<cmd>norm! K<cr>", "Keywordprg" },
    m = { "<cmd>lua require('treesj').toggle()<cr>", "ToggleNode" },
    o = {
        name = "Obsidian",
        f = { "<cmd>ObsidianFollowLink<cr>", "Follow link" },
        n = { "<cmd>ObsidianNew<cr>", "New file" },
        s = { "<cmd>ObsidianQuickSwitch<cr>", "Quick Switch" },
        o = { string.format("<cmd>edit %s<cr>", os.getenv("SECOND_BRAIN")), "Open Obsidian" },
    },
    r = {
        name = "Search and Replace",
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
        q = { "<C-w>q", "Close" },
        h = { "<C-w>h", "Go Left" },
        j = { "<C-w>j", "Go Right" },
        k = { "<C-w>k", "Go Up" },
        l = { "<C-w>l", "Go Down" },
        m = { "<cmd>WindowsMaximize<cr>", "Windows Maximize" },
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
        q = { "<cmd>:qa<cr>", "Quit all buffers" },
        a = { "<cmd>:wqa<cr>", "Save all buffers and quit" },
        f = { "<cmd>:qa!<cr>", "Force quit all buffers" },
        r = { "<cmd>lua require('persistence').load()<cr>", "Resore session" },
        l = { "<cmd>lua require('persistence').load({ last = true })<cr>", "Restore last session" },
        Q = { "<cmd>lua require('persistence').stop()<cr>", "Quit without saving session" },
    },
    g = {
        name = "Git",
        w = { "<cmd>Telescope git_worktree theme=dropdown<cr>", "Worktree" },
        n = { "<cmd>lua require('neogit').open({kind = 'tab'})<cr>", "NeoGit" },
        l = { "<cmd>LazyGit<cr>", "LazyGit" },
        H = {
            "<cmd>lua require('gitlinker').get_repo_url({action_callback = require('gitlinker.actions').open_in_browser})<cr>",
            "Open homepage",
        },
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
        t = { "<cmd>Telescope live_grep theme=dropdown<cr>", "Text" },
        k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
        C = { "<cmd>Telescope commands<cr>", "Commands" },
        l = { "<cmd>Telescope resume theme=dropdown<cr>", "Resume last search" },
        u = { "<cmd>Telescope undo<cr>", "Undo History" },
        s = { "<cmd>Telescope spell_suggest theme=dropdown<cr>", "Suggest Spelling" },
        p = { "<cmd>YankyRingHistory<cr>", "Paste History" },
    },
    l = {
        name = "LSP",
        a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
        q = { "<cmd>TroubleToggle quickfix<cr>", "Quickfix" },
        b = { "<cmd>TroubleToggle document_diagnostics<cr>", "Buffer Diagnostics" },
        w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Diagnostics" },
        f = { "<cmd>lua vim.lsp.buf.format({async = false, timeout_ms = 10000})<cr>", "Format" },
        i = { "<cmd>LspInfo<cr>", "Info" },
        I = { "<cmd>Mason<cr>", "Mason Info" },
        l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
        r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
        s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
        S = { "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "Workspace Symbols" },
        R = { "<cmd>LspRestart<cr>", "Restart LSP in buffer" },
    },
    a = {
        name = "Annotaions",
        c = { "<cmd>lua require('neogen').generate({ type = 'class' })<cr>", "Class Doc" },
        f = { "<cmd>lua require('neogen').generate({ type = 'func' })<cr>", "Function Doc" },
        t = { "<cmd>lua require('neogen').generate({ type = 'type' })<cr>", "Type Doc" },
    },
    d = {
        name = "Debug",
        u = { "<cmd>lua require('dapui').toggle({})<cr>", "Dap UI" },
        e = { "<cmd>lua require('dapui').eval({})<cr>", "Dap UI Eval" },
        b = { "<cmd>lua require('dap').toggle_breakpoint()<cr>", "Toggle Breakpoint" },
        B = {
            "<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>",
            "Breakpoint Condition",
        },
        c = { "<cmd>lua require('dap').continue()<cr>", "Continue" },
        C = { "<cmd>lua require('dap').run_to_cursor()<cr>", "Run to Cursor" },
        g = { "<cmd>lua require('dap').goto_()<cr>", "Go to line (no execute)" },
        i = { "<cmd>lua require('dap').step_into()<cr>", "Step Info" },
        j = { "<cmd>lua require('dap').down()<cr>", "Down" },
        k = { "<cmd>lua require('dap').up()<cr>", "Up" },
        l = { "<cmd>lua require('dap').run_last()<cr>", "Run Last" },
        o = { "<cmd>lua require('dap').step_out()<cr>", "Step Out" },
        O = { "<cmd>lua require('dap').step_over()<cr>", "Step Over" },
        p = { "<cmd>lua require('dap').pause()<cr>", "Pause" },
        r = { "<cmd>lua require('dap').repl.toggle()<cr>", "Toggle REPL" },
        s = { "<cmd>lua require('dap').session()<cr>", "Session" },
        t = { "<cmd>lua require('dap').terminat()<cr>", "Terminate" },
        w = { "<cmd>lua require('dap.ui.widgets').hover()<cr>", "Widgets" },
    },
}

local vmappings = {
    ["/"] = { "<Plug>(comment_toggle_linewise_visual)", "Comment toggle linewise (visual)" },
    l = {
        name = "LSP",
        a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
    },
    d = {
        name = "Debug",
        e = { "<cmd>lua require('dapui').eval({})<cr>", "Dap UI Eval" },
    },
}

which_key.register(mappings, opts)
which_key.register(vmappings, vopts)
