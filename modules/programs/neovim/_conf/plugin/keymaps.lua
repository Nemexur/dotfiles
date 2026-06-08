-- Use `<leader>na` and `<leader>ni` for incremental selection
local copy_keymap = function(mode, from_lhs, to_lhs)
    local keymap = vim.fn.maparg(from_lhs, mode, false, true)
    local rhs = keymap.callback or keymap.rhs
    vim.keymap.set(mode, to_lhs, rhs, { desc = keymap.desc })
end
copy_keymap("x", "an", "<leader>na")
copy_keymap("x", "in", "<leader>ni")

-- better up/down
Snacks.keymap.set({ "n", "x", "v" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
Snacks.keymap.set({ "n", "x", "v" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
Snacks.keymap.set({ "n", "x", "v" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
Snacks.keymap.set({ "n", "x", "v" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- visual move
Snacks.keymap.set("v", "J", ":m '>+1<cr>gv=gv", { desc = "Move visual down" })
Snacks.keymap.set("v", "K", ":m '<-2<cr>gv=gv", { desc = "Move visual up" })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
Snacks.keymap.set("v", "<", "<gv")
Snacks.keymap.set("v", ">", ">gv")
Snacks.keymap.set("n", "n", "'Nn'[v:searchforward].'zz'", { expr = true, desc = "Next search result" })
Snacks.keymap.set("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
Snacks.keymap.set("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
Snacks.keymap.set("n", "N", "'nN'[v:searchforward].'zz'", { expr = true, desc = "Prev search result" })
Snacks.keymap.set("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
Snacks.keymap.set("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
Snacks.keymap.set("n", "[e", ":<c-u>execute 'move -1-'. v:count1<cr>", { desc = "Move one line up" })
Snacks.keymap.set("n", "]e", ":<c-u>execute 'move +'. v:count1<cr>", { desc = "Move one line down" })

-- delete with mini-pairs
Snacks.keymap.set(
    "i",
    "<C-h>",
    "v:lua.MiniPairs.bs()",
    { expr = true, replace_keycodes = false, desc = "Delete character" }
)
Snacks.keymap.set(
    "i",
    "<C-w>",
    'v:lua.MiniPairs.bs("\23")',
    { expr = true, replace_keycodes = false, desc = "Delete word" }
)
Snacks.keymap.set(
    "i",
    "<C-u>",
    'v:lua.MiniPairs.bs("\21")',
    { expr = true, replace_keycodes = false, desc = "Delete to the beginning" }
)

-- sane C-d, C-u
Snacks.keymap.set("n", "<C-d>", "<C-d>zz")
Snacks.keymap.set("n", "<C-u>", "<C-u>zz")

-- commenting
Snacks.keymap.set("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Below" })
Snacks.keymap.set("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Above" })

-- size of splits
Snacks.keymap.set("n", "<M-,>", "<c-w>5<", { desc = "Increase size of vsplit" })
Snacks.keymap.set("n", "<M-.>", "<c-w>5>", { desc = "Decrease size of vsplit" })
Snacks.keymap.set("n", "<M-t>", "<C-W>5+", { desc = "Increase size of hsplit" })
Snacks.keymap.set("n", "<M-s>", "<C-W>5-", { desc = "Decrease size of hsplit" })

-- easily hit escape in terminal mode.
Snacks.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")

-- expand luasnip snippets
Snacks.keymap.set({ "i", "s" }, "<c-k>", function()
    local ls_ok, ls = pcall(require, "luasnip")
    if not ls_ok then
        return
    end
    if ls.expand_or_jumpable() then
        ls.expand_or_jump()
    end
end, { desc = "Snippet Jump Next" })
Snacks.keymap.set({ "i", "s" }, "<c-j>", function()
    local ls_ok, ls = pcall(require, "luasnip")
    if not ls_ok then
        return
    end
    if ls.jumpable(-1) then
        ls.jump(-1)
    end
end, { desc = "Snippet Jump Prev" })

-- inspect treesitter
Snacks.keymap.set("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })
Snacks.keymap.set("n", "<leader>uI", function()
    vim.treesitter.inspect_tree()
    vim.api.nvim_input("I")
end, { desc = "Inspect Tree" })
Snacks.keymap.set("n", "<leader>ul", "<cmd>lua require('noice').cmd('lasy')<cr>", { desc = "Noice Last Entry" })
Snacks.keymap.set("n", "<leader>uh", "<cmd>lua require('noice').cmd('history')<cr>", { desc = "Noice History" })
Snacks.keymap.set("n", "<leader>ue", "<cmd>lua require('noice').cmd('errors')<cr>", { desc = "Noice Errors" })

-- makrdown keymaps
Snacks.keymap.set("n", "<leader>ue", "<cmd>lua require('noice').cmd('errors')<cr>", { desc = "Noice Errors" })
