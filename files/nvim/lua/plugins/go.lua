return {
    {
        "olexsmir/gopher.nvim",
        ft = "go",
        opts = {},
        build = function()
            vim.cmd("silent! GoInstallDeps")
        end,
    },
}
