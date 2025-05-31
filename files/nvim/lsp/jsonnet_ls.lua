-- common jsonnet library paths
local function jsonnet_path(root_dir)
    local paths = {
        root_dir .. "/lib",
        root_dir .. "/vendor",
    }
    return table.concat(paths, ":")
end

return {
    cmd = { "jsonnet-language-server" },
    filetypes = { "jsonnet", "libsonnet" },
    single_file_support = true,
    root_dir = function(fname)
        return vim.fs.dirname(vim.fs.find(".git", { path = fname, upward = true })[1])
    end,
    on_new_config = function(new_config, root_dir)
        if not new_config.cmd_env then
            new_config.cmd_env = {}
        end
        if not new_config.cmd_env.JSONNET_PATH then
            new_config.cmd_env.JSONNET_PATH = jsonnet_path(root_dir)
        end
    end,
    settings = {
        formatting = {
            Indent = 4,
            StringStyle = "double",
        },
        enable_lint_diagnostics = true,
        show_docstring_in_completion = true,
    },
}
