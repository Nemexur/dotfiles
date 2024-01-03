vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0

local opts = {
    mouse = "a",
    clipboard = "unnamedplus",
    timeoutlen = 300,
    conceallevel = 3,
    fileencoding = "utf-8",
    confirm = true,
    number = true,
    relativenumber = true,
    ignorecase = true,
    expandtab = true,
    tabstop = 4,
    shiftwidth = 4,
    shiftround = true,
    cursorline = true,
    smartcase = true,
    smartindent = true,
    splitbelow = true,
    splitright = true,
    scrolloff = 4,
    sidescrolloff = 8,
    undofile = true,
    cmdheight = 1,
    termguicolors = true,
    pumheight = 10,
    writebackup = false,
    hidden = true,
    hlsearch = true,
    title = true,
    updatetime = 200,
    grepprg = "rg --vimgrep",
    wildmode = "longest:full,full",
    undodir = os.getenv("HOME") .. "/.vim/undodir",
    guifont = "JetBrainsMono NF",
    sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" },
    fillchars = {
        foldopen = "",
        foldclose = "",
        fold = " ",
        foldsep = " ",
        diff = "╱",
        eob = " ",
    },
}
for k, v in pairs(opts) do
    vim.opt[k] = v
end

if vim.fn.has("nvim-0.10") == 1 then
    vim.opt.smoothscroll = true
end
