local wk_ok, wk = pcall(require, "which-key")
if not wk_ok then
    return
end

wk.add({
    {"<leader>c", group = "Golang"},
    {"<leader>ci", "<cmd>GoDoc<cr>", desc = "Browse documentation"},
    {"<leader>cd", "<cmd>lua requie('dap-go').debug_test()<cr>", desc = "Debug tests"},
})
