-- general
lvim.log.level = "warn"
lvim.colorscheme = "lunar"
lvim.use_icons = true
lvim.reload_config_on_save = false
lvim.transparent_window = true

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
    timeoutlen = 30, -- time to wait for a mapped sequence to complete (in milliseconds)
    ttimeoutlen = 0,
    conceallevel = 0, -- so that `` is visible in markdown files
    fileencoding = "utf-8", -- the encoding written to a file
    number = true, -- set numbered lines
    relativenumber = true, -- set relative numbered lines
    ignorecase = true, -- ignore case in search patterns
    tabstop = 4, -- insert 4 spaces for a tab
    shiftwidth = 4, -- the number of spaces inserted for each indentation
    smartcase = true, -- smart case
    smartindent = true, -- make indenting smarter again
    splitbelow = true, -- force all horizontal splits to go below current window
    splitright = true, -- force all vertical splits to go to the right of current
    scrolloff = 0,
    sidescrolloff = 5,
    fixeol = true,
    guifont = "JetBrainsMono Nerd Font"
}
for k, v in pairs(options) do
    vim.opt[k] = v
end

-- Neovide
if vim.g.neovide then
    vim.g.neovide_input_use_logo = 1 -- enable use of the logo (cmd) key
    vim.g.neovide_input_macos_alt_is_meta = false
    vim.g.neovide_remember_window_size = true
    vim.g.CtrlSpaceDefaultMappingKey = "<C-space> "
    vim.keymap.set('n', '<D-s>', ':w<CR>') -- Save
    vim.keymap.set('v', '<D-c>', '"+y') -- Copy
    vim.keymap.set('n', '<D-v>', '"+P') -- Paste normal mode
    vim.keymap.set('v', '<D-v>', '"+P') -- Paste visual mode
    vim.keymap.set('c', '<D-v>', '<C-R>+') -- Paste command mode
    vim.keymap.set('i', '<D-v>', '<ESC>l"+Pli') -- Paste insert mode
end
