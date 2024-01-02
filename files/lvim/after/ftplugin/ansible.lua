local lsp_manager = require "lvim.lsp.manager"

vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "ansiblels" })
lsp_manager.setup("ansiblels", {
    filetypes = { "yaml.ansible" },
    on_attach = function(client, bufnr)
        require("lvim.lsp").common_on_attach(client, bufnr)
        require("lsp_signature").on_attach(
            { bind = true, handler_opts = { border = "rounded" } },
            bufnr
        )
    end,
    on_init = require("lvim.lsp").common_on_init,
    capabilities = require("lvim.lsp").common_capabilities(),
    settings = {
        ansible = {
            ansible = {
                path = "ansible"
            },
            executionEnvironment = {
                enabled = false
            },
            python = {
                interpreterPath = "python"
            },
            validation = {
                enabled = true,
                lint = {
                    enabled = true,
                    path = "ansible-lint"
                }
            }
        }
    }
})
