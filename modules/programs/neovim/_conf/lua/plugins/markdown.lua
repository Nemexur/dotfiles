return {
    {
        "OXY2DEV/markview.nvim",
        ft = "markdown",
        dependencies = { "saghen/blink.cmp" },
    },
    {
        "iamcco/markdown-preview.nvim",
        ft = "markdown",
        build = "cd app && yarn install",
        init = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    },
}
