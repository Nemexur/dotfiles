vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--branch=stable",
        lazyrepo,
        lazypath,
    })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- fzf
local fzf_path = ""
local sysname = vim.loop.os_uname().sysname
if sysname == "Darwin" then
    fzf_path = "/opt/homebrew/opt/fzf"
end

require("lazy").setup("plugins", {
    defaults = { lazy = true },
    install = { colorscheme = { "eldritich" } },
    change_detection = { enabled = true, notify = false },
    ui = {
        border = "rounded",
        backdrop = 100,
        title = "Plugins",
        title_pos = "center",
    },
    performance = {
        cache = {
            enabled = true,
        },
        rtp = {
            reset = true,
            paths = { fzf_path },
            disabled_plugins = {
                "gzip",
                "plugin",
                "matchit",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
})
