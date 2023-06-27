local lsp_manager = require "lvim.lsp.manager"

local options = {
    tabstop = 2,    -- insert 2 spaces for a tab
    shiftwidth = 2, -- the number of spaces inserted for each indentation
    expandtab = true,
}
for k, v in pairs(options) do
    vim.opt_local[k] = v
end

-- Docker Compose
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "docker_compose_language_service" })
lsp_manager.setup("docker_compose_language_service", {
    filetypes = { "yaml.docker-compose" },
    cmd = { "docker-compose-langserver", "--stdio" },
    on_attach = function(client, bufnr)
        require("lvim.lsp").common_on_attach(client, bufnr)
        require("lsp_signature").on_attach(
            { bind = true, handler_opts = { border = "rounded" } },
            bufnr
        )
    end,
    on_init = require("lvim.lsp").common_on_init,
    capabilities = require("lvim.lsp").common_capabilities(),
})
