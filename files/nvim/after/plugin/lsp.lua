local lsp_zero_ok, lsp_zero = pcall(require, "lsp-zero")
if not lsp_zero_ok then
    return
end

lsp_zero.extend_lspconfig()
lsp_zero.on_attach(function(client, bufnr)
    lsp_zero.default_keymaps({
        buffer = bufnr,
        preserve_mappings = false,
    })
    require("lsp_signature").on_attach({ bind = true, handler_opts = { border = "rounded" } }, bufnr)
end)

lsp_zero.format_on_save({
    format_opts = {
        async = false,
        timeout_ms = 10000,
    },
    servers = {
        ["null-ls"] = { "lua", "go", "json", "md" },
    },
})

local mason_lspconfig_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_ok then
    return
end

mason_lspconfig.setup({
    ensure_installed = {
        "ansiblels",
        "bashls",
        "clangd",
        "docker_compose_language_service",
        "dockerls",
        "golangci_lint_ls",
        "gopls",
        "helm_ls",
        "jsonls",
        "lua_ls",
        "pyright",
        "ruff_lsp",
        "sqlls",
        "vimls",
        "yamlls",
    },
    handlers = {
        lsp_zero.default_setup,
        lua_ls = function()
            local lua_opts = lsp_zero.nvim_lua_ls()
            require("lspconfig").lua_ls.setup(lua_opts)
        end,
    },
})
