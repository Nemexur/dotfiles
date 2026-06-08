return {
    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "esmuellert/codediff.nvim",
            "m00qek/baleia.nvim",
            "folke/snacks.nvim",
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

                -- stylua: ignore start
                Snacks.keymap.set("n", "]h", function()
                    if vim.wo.diff then
                        vim.cmd.normal({ "]c", bang = true })
                    else
                        gs.nav_hunk("next")
                    end
                end, { desc = "Next Hunk", buffer = buffer })
                Snacks.keymap.set("n", "[h", function()
                    if vim.wo.diff then
                        vim.cmd.normal({ "[c", bang = true })
                    else
                        gs.nav_hunk("prev")
                    end
                end, { desc = "Prev Hunk", buffer = buffer })
                Snacks.keymap.set("n", "]H", function() gs.nav_hunk("last") end, { desc = "Last Hunk", buffer = buffer })
                Snacks.keymap.set("n", "[H", function() gs.nav_hunk("first") end,
                    { desc = "First Hunk", buffer = buffer })
                Snacks.keymap.set("n", "<leader>ghs", gs.stage_hunk, { desc = "Stage Hunk", buffer = buffer })
                Snacks.keymap.set('v', '<leader>hs', function() gs.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end,
                    { desc = "Stage hunk", buffer = buffer })
                Snacks.keymap.set("n", "<leader>ghr", gs.reset_hunk, { desc = "Reset Hunk", buffer = buffer })
                Snacks.keymap.set('v', '<leader>hr', function() gs.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end,
                    { desc = "Reset hunk", buffer = buffer })
                Snacks.keymap.set("n", "<leader>ghS", gs.stage_buffer, { desc = "Stage Buffer", buffer = buffer })
                Snacks.keymap.set("n", "<leader>ghR", gs.reset_buffer, { desc = "Reset Buffer", buffer = buffer })
                Snacks.keymap.set("n", "<leader>ghp", gs.preview_hunk_inline,
                    { desc = "Preview Hunk Inline", buffer = buffer })
                Snacks.keymap.set("n", "<leader>ghb", function() gs.blame_line({ full = true }) end,
                    { desc = "Blame Line", buffer = buffer })
                Snacks.keymap.set("n", "<leader>ghB", gs.blame, { desc = "Blame Buffer", buffer = buffer })
                Snacks.keymap.set("n", "<leader>ghd", gs.diffthis, { desc = "Diff This", buffer = buffer })
                Snacks.keymap.set("n", "<leader>ghD", function() gs.diffthis("~") end,
                    { desc = "Diff This ~", buffer = buffer })
                Snacks.keymap.set('n', '<leader>ghQ', function() gs.setqflist('all') end,
                    { desc = "QuickFix list with hunks (all)", buffer = buffer })
                Snacks.keymap.set('n', '<leader>ghq', gs.setqflist,
                    { desc = "QuickFix list with hunks (buffer)", buffer = buffer })
                Snacks.keymap.set({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>",
                    { desc = "GitSigns Select Hunk", buffer = buffer })
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
}
