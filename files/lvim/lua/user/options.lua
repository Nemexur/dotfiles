-- general
lvim.log.level = "warn"
lvim.colorscheme = "dracula"
lvim.use_icons = true
lvim.reload_config_on_save = false
lvim.transparent_window = true
lvim.format_on_save.enabled = true
lvim.format_on_save.pattern = { "*.go", "*.lua", "*.json", "*.md" }

-- LunarVim builtin
lvim.builtin.dap.active = true
lvim.builtin.alpha.active = true
lvim.builtin.illuminate.active = true
lvim.builtin.autopairs.active = true
lvim.builtin.comment.active = true
lvim.builtin.terminal.active = true
lvim.builtin.bufferline.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.cmp.completion.keyword_length = 2
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false
lvim.builtin.treesitter.matchup.enable = true

-- General vim settings
local options = {
    mouse = "a",
    timeoutlen = 30,
    ttimeoutlen = 0,
    conceallevel = 0,
    fileencoding = "utf-8",
    number = true,
    relativenumber = true,
    ignorecase = true,
    tabstop = 4,
    shiftwidth = 4,
    smartcase = true,
    smartindent = true,
    splitbelow = true,
    splitright = true,
    scrolloff = 0,
    sidescrolloff = 5,
    fixeol = true,
    undofile = true,
    foldenable = false,
    showtabline = 0,
    undodir = os.getenv("HOME") .. "/.vim/undodir",
    guifont = "JetBrainsMono NF",
    -- hlsearch = true,
}
for k, v in pairs(options) do
    vim.opt[k] = v
end
