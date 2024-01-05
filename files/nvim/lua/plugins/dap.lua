return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "jay-babu/mason-nvim-dap.nvim",
            "theHamsta/nvim-dap-virtual-text",
        },
    },
    {
        "rcarriga/nvim-dap-ui",
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
    },
    {
        "theHamsta/nvim-dap-virtual-text",
        opts = {},
    },
    {
        "jay-babu/mason-nvim-dap.nvim",
        event = "VeryLazy",
        cmd = { "DapInstall", "DapUninstall" },
        opts = {
            automatic_installation = false,
            ensure_installed = { "python", "delve", "cppdbg" },
        },
        dependencies = { "williamboman/mason.nvim" },
    },
}
