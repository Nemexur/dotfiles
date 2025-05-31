return {
    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "sindrets/diffview.nvim",
        },
        opts = {
            integrations = {
                snacks = true,
                diffview = true,
            },
            kind = "auto",
            disable_insert_on_commit = true,
            grap_style = "kitty",
        },
        keys = {
            { "<leader>gn", "<cmd>lua require('neogit').open()<cr>", desc = "NeoGit" },
        },
    },
    {
        "kdheepak/lazygit.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        cmd = "LazyGit",
        keys = {
            { "<leader>gl", "<cmd>LazyGit<cr>", desc = "LazyGit", mode = "n" },
        },
    },
    {
        "ruifm/gitlinker.nvim",
        opts = { mappings = nil },
        keys = {
            {
                "<leader>gH",
                "<cmd>lua require('gitlinker').get_repo_url({action_callback = require('gitlinker.actions').open_in_browser})<cr>",
                desc = "Open homepage",
                mode = "n",
            },
        },
    },
    {
        "lewis6991/gitsigns.nvim",
        event = "VeryLazy",
        opts = {
            signs = {
                add = { text = "▎" },
                change = { text = "▎" },
                delete = { text = "" },
                topdelete = { text = "" },
                changedelete = { text = "▎" },
                untracked = { text = "▎" },
            },
            signs_staged = {
                add = { text = "▎" },
                change = { text = "▎" },
                delete = { text = "" },
                topdelete = { text = "" },
                changedelete = { text = "▎" },
            },
            on_attach = function(buffer)
                local gs = require("gitsigns")

                local function map(mode, l, r, desc)
                    vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
                end

                -- stylua: ignore start
                map("n", "]h", function()
                    if vim.wo.diff then
                        vim.cmd.normal({ "]c", bang = true })
                    else
                        gs.nav_hunk("next")
                    end
                end, "Next Hunk")
                map("n", "[h", function()
                    if vim.wo.diff then
                        vim.cmd.normal({ "[c", bang = true })
                    else
                        gs.nav_hunk("prev")
                    end
                end, "Prev Hunk")
                map("n", "]H", function() gs.nav_hunk("last") end, "Last Hunk")
                map("n", "[H", function() gs.nav_hunk("first") end, "First Hunk")
                map("n", "<leader>ghs", gs.stage_hunk, "Stage Hunk")
                map('v', '<leader>hs', function() gs.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end, "Stage hunk")
                map("n", "<leader>ghr", gs.reset_hunk, "Reset Hunk")
                map('v', '<leader>hr', function() gs.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end, "Reset hunk")
                map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
                map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
                map("n", "<leader>ghp", gs.preview_hunk_inline, "Preview Hunk Inline")
                map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
                map("n", "<leader>ghB", gs.blame, "Blame Buffer")
                map("n", "<leader>ghd", gs.diffthis, "Diff This")
                map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
                map('n', '<leader>ghQ', function() gs.setqflist('all') end, "QuickFix list with hunks (all)")
                map('n', '<leader>ghq', gs.setqflist, "QuickFix list with hunks (buffer)")
                map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
            end,
        },
    },
    {
        "pwntester/octo.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "folke/snacks.nvim",
            "nvim-tree/nvim-web-devicons",
        },
        opts = { picker = "snacks" },
        cmd = "Octo",
    },
    {
        "ThePrimeagen/git-worktree.nvim",
        opts = {},
    },
}
