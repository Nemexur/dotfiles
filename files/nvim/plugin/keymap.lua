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

-- better up/down
map({ "n", "x", "v" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x", "v" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x", "v" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map({ "n", "x", "v" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- visual move
map("v", "J", ":m '>+1<cr>gv=gv", { desc = "Move visual down" })
map("v", "K", ":m '<-2<cr>gv=gv", { desc = "Move visual up" })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "n", "'Nn'[v:searchforward].'zz'", { expr = true, desc = "Next search result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("n", "N", "'nN'[v:searchforward].'zz'", { expr = true, desc = "Prev search result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- delete with mini-pairs
map("i", "<C-h>", "v:lua.MiniPairs.bs()", { expr = true, replace_keycodes = false, desc = "Delete character" })
map("i", "<C-w>", 'v:lua.MiniPairs.bs("\23")', { expr = true, replace_keycodes = false, desc = "Delete word" })
map("i", "<C-u>", 'v:lua.MiniPairs.bs("\21")', { expr = true, replace_keycodes = false, desc = "Delete to the beginning" })

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- sane C-d, C-u
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- commenting
map("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Below" })
map("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Above" })

-- size of splits
map("n", "<M-,>", "<c-w>5<", { desc = "Increase size of vsplit" })
map("n", "<M-.>", "<c-w>5>", { desc = "Decrease size of vsplit" })
map("n", "<M-t>", "<C-W>5+", { desc = "Increase size of hsplit" })
map("n", "<M-s>", "<C-W>5-", { desc = "Decrease size of hsplit" })

-- easily hit escape in terminal mode.
map("t", "<esc><esc>", "<c-\\><c-n>")

-- expand luasnip snippets
map({ "i", "s" }, "<c-k>", function()
    local ls_ok, ls = pcall(require, "luasnip")
    if not ls_ok then
        return
    end
    if ls.expand_or_jumpable() then
        ls.expand_or_jump()
    end
end, { desc = "Snippet Jump Next" })
map({ "i", "s" }, "<c-j>", function()
    local ls_ok, ls = pcall(require, "luasnip")
    if not ls_ok then
        return
    end
    if ls.jumpable(-1) then
        ls.jump(-1)
    end
end, { desc = "Snippet Jump Prev" })
