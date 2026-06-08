return {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    cmd = "ConformInfo",
    opts = {
        -- Define your formatters
        formatters_by_ft = {
            go = { "gofumpt", "goimports", "golines" },
            lua = { "stylua" },
            markdown = { "prettier", "markdownlint-cli2", "markdown-toc" },
            ["markdown.mdx"] = { "prettier", "markdownlint-cli2", "markdown-toc" },
            python = function(bufnr)
                if require("conform").get_formatter_info("ruff_format", bufnr).available then
                    return { "ruff_format" }
                else
                    return { "isort", "black" }
                end
            end,
            sh = { "shfmt" },
            sql = { "sqruff" },
            yaml = { "yamlfmt" },
            -- Lsp Formatting
            nix = { lsp_format = "prefer" },
            json = { lsp_format = "prefer" },
            jsonnet = { lsp_format = "prefer" },
            libsonnet = { lsp_format = "prefer" },
            -- Use the "*" filetype to run formatters on all filetypes.
            ["*"] = { "codespell" },
            -- Use the "_" filetype to run formatters on filetypes that don't
            -- have other formatters configured.
            ["_"] = { "trim_whitespace" },
        },
        formatters = {
            yamlfmt = {
                prepend_args = {
                    "-formatter",
                    vim.iter({
                        "indent=2",
                        "include_document_start=true",
                        "max_line_length=100",
                        "force_quote_style=double",
                    }):join(","),
                },
            },
            ["markdown-toc"] = {
                condition = function(_, ctx)
                    for _, line in ipairs(vim.api.nvim_buf_get_lines(ctx.buf, 0, -1, false)) do
                        if line:find("<!%-%- toc %-%->") then
                            return true
                        end
                    end
                end,
            },
            ["markdownlint-cli2"] = {
                condition = function(_, ctx)
                    local diag = vim.tbl_filter(function(d)
                        return d.source == "markdownlint"
                    end, vim.diagnostic.get(ctx.buf))
                    return #diag > 0
                end,
            },
        },
    },
    init = function()
        vim.opt.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
}
