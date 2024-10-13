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

local function toggle_term()
    --- @return integer Window handle
    local function new_win()
        vim.cmd.new()
        vim.cmd.wincmd("J")
        vim.api.nvim_win_set_height(0, 12)
        vim.wo.winfixheight = true
        return vim.api.nvim_get_current_win()
    end

    --- @return integer Buffer handle
    local function get_buf()
        local is_valid_buf = vim.g.term_buf_id ~= nil and vim.api.nvim_buf_is_valid(vim.g.term_buf_id)
        if is_valid_buf then
            return vim.g.term_buf_id
        end
        vim.cmd.term()
        return vim.api.nvim_get_current_buf()
    end

    --- @param win_id integer Window handle
    --- @param buf_id integer Buffer handle
    local function update_win_buf(win_id, buf_id)
        local curr_win_buf = vim.api.nvim_win_get_buf(win_id)
        if buf_id == curr_win_buf then
            return
        end
        vim.api.nvim_win_set_buf(win_id, buf_id)
        vim.api.nvim_buf_delete(curr_win_buf, { force = true })
    end

    local is_win_open = vim.g.term_win_id ~= nil and vim.api.nvim_win_is_valid(vim.g.term_win_id)
    if is_win_open then
        vim.api.nvim_win_hide(vim.g.term_win_id)
        vim.g.term_win_id = nil
        return
    end
    vim.g.term_win_id = new_win()
    vim.g.term_buf_id = get_buf()
    update_win_buf(vim.g.term_win_id, vim.g.term_buf_id)
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

-- Folding
map("n", "zR", "<cmd>lua require('ufo').openAllFolds()<cr>", { desc = "Open all folds" })
map("n", "zM", "<cmd>lua require('ufo').closeAllFolds()<cr>", { desc = "Close all folds" })

-- substitute.nvim
map("v", "s", "<cmd>lua require('substitute').visual()<cr>", { desc = "Substitute visual" })
map("v", "X", "<cmd>lua require('substitute.exchange').visual()<cr>", { desc = "Substitute exchange visual" })

-- flash.nvim
map({ "n", "x", "o" }, "<C-f>", "<cmd>lua require('flash').jump()<cr>", { desc = "Flash jump" })
map({ "o", "x" }, "r", "<cmd>lua require('flash').treesitter_search()<cr>", { desc = "Flash Treesitter Search" })

-- Size of splits
map("n", "<M-,>", "<c-w>5<", { desc = "Increase size of vsplit" })
map("n", "<M-.>", "<c-w>5>", { desc = "Decrease size of vsplit" })
map("n", "<M-t>", "<C-W>+", { desc = "Increase size of hsplit" })
map("n", "<M-s>", "<C-W>-", { desc = "Decrease size of hsplit" })

-- Easily hit escape in terminal mode.
map("t", "<esc><esc>", "<c-\\><c-n>")

-- Open a terminal at the bottom of the screen with a fixed height.
map("n", "<c-t>", toggle_term, { desc = "Toggle [T]erminal" })
map("t", "<c-t>", toggle_term, { desc = "Toggle [^] [T]erminal" })

-- Expand luasnip snippets
map({ "i", "s" }, "<c-k>", function()
    local ls_ok, ls = pcall(require, "luasnip")
    if not ls_ok then
        return
    end
    if ls.expand_or_jumpable() then
        ls.expand_or_jump()
    end
end, { silent = true })
map({ "i", "s" }, "<c-j>", function()
    local ls_ok, ls = pcall(require, "luasnip")
    if not ls_ok then
        return
    end
    if ls.jumpable(-1) then
        ls.jump(-1)
    end
end, { silent = true })

-- Harpoon
map("n", "<C-e>", function()
    local harpoon_ok, harpoon = pcall(require, "harpoon")
    if not harpoon_ok then
        return
    end
    harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Harpoon List" })

local wk_ok, wk = pcall(require, "which-key")
if not wk_ok then
    return
end

wk.add({
    { "<leader>x", "<cmd>. lua<cr>", desc = "Execute the current line", mode = "n" },
    { "<leader>u", "<cmd>Telescope undo<cr>", desc = "Undo History", mode = "n" },
    { "<leader>e", "<cmd>Oil<cr>", desc = "Open parent directory", mode = "n" },
    { "<leader>h", "<cmd>lua require('harpoon'):list():append()<CR>", desc = "Harpoon append", mode = "n" },
    { "<leader>m", "<cmd>lua require('treesj').toggle()<cr>", desc = "Toggle Node", mode = "n" },
    { "<leader>z", "za", desc = "Toggle Folding", mode = "n" },
    { "<leader><leader>x", "<cmd>source %<cr>", desc = "Exectue the current file", mode = "n" },
    -- Obsidian
    { "<leader>o", group = "Obsidian" },
    { "<leader>ol", "<cmd>ObsidianFollowLink<cr>", desc = "Follow link", mode = "n" },
    { "<leader>on", "<cmd>ObsidianNew<cr>", desc = "New file", mode = "n" },
    { "<leader>of", "<cmd>ObsidianQuickSwitch<cr>", desc = "Quick Switch", mode = "n" },
    { "<leader>ot", "<cmd>ObsidianSearch<cr>", desc = "Search Inside Notes", mode = "n" },
    {
        "<leader>oo",
        string.format("<leader>o", "<cmd>edit %s<cr>", os.getenv("SECOND_BRAIN")),
        desc = "Open Obsidian",
        mode = "n",
    },
    -- Search and Replace
    { "<leader>r", group = "Search and Replace" },
    { "<leader>rr", "<cmd>lua require('spectre').open()<cr>", desc = "Replace", mode = "n" },
    {
        "<leader>rw",
        "<cmd>lua require('spectre').open_visual({select_word=true})<cr>",
        desc = "Replace Word",
        mode = "n",
    },
    { "<leader>rb", "<cmd>lua require('spectre').open_file_search()<cr>", desc = "Replace Buffer", mode = "n" },
    { "<leader>rs", "<cmd>lua require('ssr').open()<cr>", desc = "Structrual Search", mode = "n" },
    { "<leader>rn", ":IncRename ", desc = "Incremental Rename", mode = "n" },
    -- Windows
    { "<leader>w", group = "Windows" },
    { "<leader>ws", "<C-w>s", desc = "Horizontal", mode = "n" },
    { "<leader>wv", "<C-w>v", desc = "Vertical", mode = "n" },
    { "<leader>wq", "<C-w>q", desc = "Close", mode = "n" },
    { "<leader>wh", "<C-w>h", desc = "Go Left", mode = "n" },
    { "<leader>wj", "<C-w>j", desc = "Go Right", mode = "n" },
    { "<leader>wk", "<C-w>k", desc = "Go Up", mode = "n" },
    { "<leader>wl", "<C-w>l", desc = "Go Down", mode = "n" },
    { "<leader>wm", "<cmd>WindowsMaximize<cr>", desc = "Windows Maximize", mode = "n" },
    -- Buffers
    { "<leader>b", group = "Buffers" },
    { "<leader>bb", "<cmd>Telescope buffers previewer=false theme=dropdown<cr>", desc = "Find", mode = "n" },
    { "<leader>bp", "<cmd>bprevious<cr>", desc = "Previous", mode = "n" },
    { "<leader>bn", "<cmd>bnext<cr>", desc = "Next", mode = "n" },
    { "<leader>bW", "<cmd>noautocmd w<cr>", desc = "Save without formatting (noautocmd)", mode = "n" },
    { "<leader>bq", "<cmd>bd<cr>", desc = "Quit buffer", mode = "n" },
    { "<leader>bw", "<cmd>lua require('wrapping').toggle_wrap_mode()<cr>", desc = "Toggle wrapping", mode = "n" },
    { "<leader>bc", "<cmd>CloakToggle<cr>", desc = "Toggle Cloak", mode = "n" },
    -- Quit
    { "<leader>q", group = "Quit" },
    { "<leader>qq", "<cmd>:qa<cr>", desc = "Quit all buffers", mode = "n" },
    { "<leader>qa", "<cmd>:wqa<cr>", desc = "Save all buffers and quit", mode = "n" },
    { "<leader>qf", "<cmd>:qa!<cr>", desc = "Force quit all buffers", mode = "n" },
    { "<leader>qr", "<cmd>lua require('persistence').load()<cr>", desc = "Restore session", mode = "n" },
    {
        "<leader>ql",
        "<cmd>lua require('persistence').load({ last = true })<cr>",
        desc = "Restore last session",
        mode = "n",
    },
    { "<leader>qQ", "<cmd>lua require('persistence').stop()<cr>", desc = "Quit without saving session", mode = "n" },
    -- Git
    { "<leader>g", group = "Git" },
    { "<leader>gw", "<cmd>Telescope git_worktree theme=dropdown<cr>", desc = "Worktree", mode = "n" },
    { "<leader>gn", "<cmd>lua require('neogit').open({kind = 'tab'})<cr>", desc = "NeoGit", mode = "n" },
    { "<leader>gl", "<cmd>LazyGit<cr>", desc = "LazyGit", mode = "n" },
    {
        "<leader>gH",
        "<cmd>lua require('gitlinker').get_repo_url({action_callback = require('gitlinker.actions').open_in_browser})<cr>",
        desc = "Open homepage",
        mode = "n",
    },
    -- Find
    { "<leader>f", group = "Find" },
    { "<leader>fb", "<cmd>Telescope git_branches theme=dropdown<cr>", desc = "Checkout branch", mode = "n" },
    { "<leader>fc", "<cmd>Telescope colorscheme<cr>", desc = "Colorscheme", mode = "n" },
    {
        "<leader>ff",
        "<cmd>Telescope find_files hidden=true previewer=false theme=dropdown<cr>",
        desc = "Find File",
        mode = "n",
    },
    { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Find Help", mode = "n" },
    { "<leader>fH", "<cmd>Telescope highlights<cr>", desc = "Find highlight groups", mode = "n" },
    { "<leader>fM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages", mode = "n" },
    { "<leader>fr", "<cmd>Telescope oldfiles theme=dropdown<cr>", desc = "Open Recent File", mode = "n" },
    { "<leader>ft", "<cmd>Telescope live_grep theme=dropdown<cr>", desc = "Text", mode = "n" },
    { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps", mode = "n" },
    { "<leader>fC", "<cmd>Telescope commands<cr>", desc = "Commands", mode = "n" },
    { "<leader>fl", "<cmd>Telescope resume theme=dropdown<cr>", desc = "Resume last search", mode = "n" },
    { "<leader>fs", "<cmd>Telescope spell_suggest theme=dropdown<cr>", desc = "Suggest Spelling", mode = "n" },
    -- LSP
    { "<leader>l", group = "LSP" },
    {
        "<leader>la",
        function()
            pcall(require, "telescope")
            vim.lsp.buf.code_action()
        end,
        desc = "Code Action",
        mode = "n",
    },
    {
        "<leader>lf",
        "<cmd>lua vim.lsp.buf.format({async = false, timeout_ms = 10000})<cr>",
        desc = "Format",
        mode = "n",
    },
    { "<leader>ll", "<cmd>lua vim.lsp.codelens.run()<cr>", desc = "CodeLens Action", mode = { "n", "v" } },
    { "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "Rename", mode = "n" },
    { "<leader>lq", "<cmd>TroubleToggle quickfix<cr>", desc = "Quickfix", mode = "n" },
    { "<leader>lb", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Buffer Diagnostics", mode = "n" },
    { "<leader>lw", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Diagnostics", mode = "n" },
    { "<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document Symbols", mode = "n" },
    { "<leader>lS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Workspace Symbols", mode = "n" },
    { "<leader>li", "<cmd>LspInfo<cr>", desc = "Info", mode = "n" },
    { "<leader>lI", "<cmd>Mason<cr>", desc = "Mason Info", mode = "n" },
    { "<leader>lR", "<cmd>LspRestart<cr>", desc = "Restart LSP in buffer", mode = "n" },
    {
        "<leader>lc",
        "<cmd>lua require('treesitter-context').go_to_context(vim.v.count1)<cr>",
        desc = "Goto Context",
        mode = "n",
    },
    -- Annotaions
    { "<leader>a", group = "Annotaions" },
    { "<leader>ac", "<cmd>lua require('neogen').generate({ type = 'class' })<cr>", desc = "Class Doc", mode = "n" },
    { "<leader>af", "<cmd>lua require('neogen').generate({ type = 'func' })<cr>", desc = "Function Doc", mode = "n" },
    { "<leader>at", "<cmd>lua require('neogen').generate({ type = 'type' })<cr>", desc = "Type Doc", mode = "n" },
    -- Debug
    { "<leader>d", group = "Debug" },
    { "<leader>du", "<cmd>lua require('dapui').toggle({})<cr>", desc = "Dap UI", mode = "n" },
    { "<leader>de", "<cmd>lua require('dapui').eval({})<cr>", desc = "Dap UI Eval", mode = { "n", "v" } },
    { "<leader>db", "<cmd>lua require('dap').toggle_breakpoint()<cr>", desc = "Toggle Breakpoint", mode = "n" },
    {
        "<leader>dB",
        "<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>",
        desc = "Breakpoint Condition",
        mode = "n",
    },
    { "<leader>dc", "<cmd>lua require('dap').continue()<cr>", desc = "Continue", mode = "n" },
    { "<leader>dC", "<cmd>lua require('dap').run_to_cursor()<cr>", desc = "Run to Cursor", mode = "n" },
    { "<leader>dg", "<cmd>lua require('dap').goto_()<cr>", desc = "Go to line (no execute)", mode = "n" },
    { "<leader>di", "<cmd>lua require('dap').step_into()<cr>", desc = "Step Info", mode = "n" },
    { "<leader>dj", "<cmd>lua require('dap').down()<cr>", desc = "Down", mode = "n" },
    { "<leader>dk", "<cmd>lua require('dap').up()<cr>", desc = "Up", mode = "n" },
    { "<leader>dl", "<cmd>lua require('dap').run_last()<cr>", desc = "Run Last", mode = "n" },
    { "<leader>do", "<cmd>lua require('dap').step_out()<cr>", desc = "Step Out", mode = "n" },
    { "<leader>dO", "<cmd>lua require('dap').step_over()<cr>", desc = "Step Over", mode = "n" },
    { "<leader>dp", "<cmd>lua require('dap').pause()<cr>", desc = "Pause", mode = "n" },
    { "<leader>dr", "<cmd>lua require('dap').repl.toggle()<cr>", desc = "Toggle REPL", mode = "n" },
    { "<leader>ds", "<cmd>lua require('dap').session()<cr>", desc = "Session", mode = "n" },
    { "<leader>dt", "<cmd>lua require('dap').terminat()<cr>", desc = "Terminate", mode = "n" },
    { "<leader>dw", "<cmd>lua require('dap.ui.widgets').hover()<cr>", desc = "Widgets", mode = "n" },
})
