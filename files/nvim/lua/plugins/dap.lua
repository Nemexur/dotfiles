return {
    {
        "mfussenegger/nvim-dap",
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
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "jay-babu/mason-nvim-dap.nvim",
            "theHamsta/nvim-dap-virtual-text",
            "leoluz/nvim-dap-go",
        },
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
    { "rcarriga/nvim-dap-ui", opts = {} },
    { "theHamsta/nvim-dap-virtual-text", opts = {} },
    { "leoluz/nvim-dap-go", opts = {} },
}
