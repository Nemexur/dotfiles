local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_ok then
    return
end

vim.filetype.add({ extension = { zsh = "zsh" } })
lspconfig.bashls.setup({ filetypes = { "sh", "zsh", "bash" } })
