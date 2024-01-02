return {
    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        lazy = true,
        dependencies = {
            "nvim-telescope/telescope-fzf-native.nvim",
            "nvim-lua/plenary.nvim",
        },
    },
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        lazy = true,
    },
    {
        "nvim-telescope/telescope-ui-select.nvim",
        lazy = true,
    },
    {
        "nvim-telescope/telescope-file-browser.nvim",
        lazy = true,
    },
}
