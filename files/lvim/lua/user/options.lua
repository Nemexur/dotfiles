-- general
lvim.log.level = "warn"
lvim.colorscheme = "lunar"
lvim.use_icons = true
lvim.reload_config_on_save = false

-- LunarVim builtin
lvim.builtin.dap.active = true
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

-- general vim settings
local options = {
    mouse = "a", -- allow the mouse to be used in neovim
    timeoutlen = 80, -- time to wait for a mapped sequence to complete (in milliseconds)
    ttimeoutlen = 0,
    conceallevel = 0, -- so that `` is visible in markdown files
    fileencoding = "utf-8", -- the encoding written to a file
    number = true, -- set numbered lines
    relativenumber = true, -- set relative numbered lines
    ignorecase = true, -- ignore case in search patterns
    tabstop = 4, -- insert 2 spaces for a tab
    shiftwidth = 4, -- the number of spaces inserted for each indentation
    smartcase = true, -- smart case
    smartindent = true, -- make indenting smarter again
    splitbelow = true, -- force all horizontal splits to go below current window
    splitright = true, -- force all vertical splits to go to the right of current
    scrolloff = 0,
    sidescrolloff = 8,
    fixeol = true,
}
for k, v in pairs(options) do
    vim.opt[k] = v
end
