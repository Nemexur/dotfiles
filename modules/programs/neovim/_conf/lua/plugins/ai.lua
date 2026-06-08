return {
    {
        "carlos-algms/agentic.nvim",
        opts = {
            provider = "pi-acp",
            keymaps = {
                prompt = { submit = { "<C-y>" } },
            },
        },
        keys = {
            {
                "<leader>aa",
                function()
                    require("agentic").toggle()
                end,
                mode = { "n", "v", "i" },
                desc = "Toggle Agentic Chat",
            },
            {
                "<leader>ac",
                function()
                    require("agentic").add_selection_or_file_to_context()
                end,
                mode = { "n", "v" },
                desc = "Add file or selection to Agentic to [C]context",
            },
            {
                "<leader>as",
                function()
                    require("agentic").new_session()
                end,
                mode = { "n", "v", "i" },
                desc = "New Agentic [S]ession",
            },
            {
                "<leader>ar", -- ai Restore
                function()
                    require("agentic").restore_session()
                end,
                desc = "Agentic Restore session",
                silent = true,
                mode = { "n", "v", "i" },
            },
            {
                "<leader>ad", -- ai Diagnostics
                function()
                    require("agentic").add_current_line_diagnostics()
                end,
                desc = "Add current line diagnostic to Agentic",
                mode = { "n" },
            },
            {
                "<leader>aD", -- ai all Diagnostics
                function()
                    require("agentic").add_buffer_diagnostics()
                end,
                desc = "Add all buffer diagnostics to Agentic",
                mode = { "n" },
            },
        },
    },
}
