local mason_dap_ok, mason_dap = pcall(require, "mason-nvim-dap")
if not mason_dap_ok then
    return
end

mason_dap.setup({
    automatic_installation = false,
    ensure_installed = { "python", "delve", "cppdbg" },
})
