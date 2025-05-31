return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "jay-babu/mason-nvim-dap.nvim",
            "theHamsta/nvim-dap-virtual-text",
            "leoluz/nvim-dap-go",
        },
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")

            dap.listeners.before.attach.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated.dapui_config = function()
                dapui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                dapui.close()
            end
        end,
        keys = {
            { "<leader>du", "<cmd>lua require('dapui').toggle({})<cr>", desc = "Dap UI", mode = "n" },
            {
                "<leader>de",
                "<cmd>lua require('dapui').eval({})<cr>",
                desc = "Dap UI Eval",
                mode = { "n", "v" },
            },
            { "<leader>db", "<cmd>lua require('dap').toggle_breakpoint()<cr>", desc = "Toggle Breakpoint", mode = "n" },
            {
                "<leader>dB",
                "<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>",
                desc = "Breakpoint Condition",
                mode = "n",
            },
            {
                "<leader>dc",
                "<cmd>lua require('dap').continue()<cr>",
                desc = "Continue",
                mode = "n",
            },
            {
                "<leader>dC",
                "<cmd>lua require('dap').run_to_cursor()<cr>",
                desc = "Run to Cursor",
                mode = "n",
            },
            {
                "<leader>dg",
                "<cmd>lua require('dap').goto_()<cr>",
                desc = "Go to line (no execute)",
                mode = "n",
            },
            {
                "<leader>di",
                "<cmd>lua require('dap').step_into()<cr>",
                desc = "Step Info",
                mode = "n",
            },
            {
                "<leader>dj",
                "<cmd>lua require('dap').down()<cr>",
                desc = "Down",
                mode = "n",
            },
            {
                "<leader>dk",
                "<cmd>lua require('dap').up()<cr>",
                desc = "Up",
                mode = "n",
            },
            {
                "<leader>dl",
                "<cmd>lua require('dap').run_last()<cr>",
                desc = "Run Last",
                mode = "n",
            },
            {
                "<leader>do",
                "<cmd>lua require('dap').step_out()<cr>",
                desc = "Step Out",
                mode = "n",
            },
            {
                "<leader>dO",
                "<cmd>lua require('dap').step_over()<cr>",
                desc = "Step Over",
                mode = "n",
            },
            {
                "<leader>dp",
                "<cmd>lua require('dap').pause()<cr>",
                desc = "Pause",
                mode = "n",
            },
            {
                "<leader>dr",
                "<cmd>lua require('dap').repl.toggle()<cr>",
                desc = "Toggle REPL",
                mode = "n",
            },
            {
                "<leader>ds",
                "<cmd>lua require('dap').session()<cr>",
                desc = "Session",
                mode = "n",
            },
            {
                "<leader>dt",
                "<cmd>lua require('dap').terminat()<cr>",
                desc = "Terminate",
                mode = "n",
            },
            {
                "<leader>dw",
                "<cmd>lua require('dap.ui.widgets').hover()<cr>",
                desc = "Widgets",
                mode = "n",
            },
        },
    },
    {
        "jay-babu/mason-nvim-dap.nvim",
        cmd = { "DapInstall", "DapUninstall" },
        opts = {
            automatic_installation = false,
            ensure_installed = { "python", "delve", "cppdbg" },
        },
        dependencies = { "williamboman/mason.nvim" },
    },
    { "rcarriga/nvim-dap-ui", opts = {}, dependencies = { "nvim-neotest/nvim-nio" } },
    { "theHamsta/nvim-dap-virtual-text", opts = {} },
    { "leoluz/nvim-dap-go", opts = {} },
}
