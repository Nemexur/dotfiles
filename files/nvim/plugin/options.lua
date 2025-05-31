-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0
-- VimTex
vim.g.vimtex_view_method = "skim"
vim.g.vimtex_quickfix_mode = 2
vim.g.vimtex_syntax_enabled = 0
-- Trouble
vim.g.trouble_lualine = true

vim.opt.mouse = "a"
vim.opt.fileencoding = "utf-8"
vim.opt.spelllang = { "en" }
vim.opt.undofile = true
vim.opt.undolevels = 10000
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.completeopt = "menu,menuone,noselect"
vim.opt.formatexpr = "v:lua.vim.lsp.formatexpr({ timeout_ms = 3000 })"
vim.opt.formatoptions = "jcroqlnt" -- tcqj
vim.opt.grepprg = "rg --vimgrep"
vim.opt.grepformat = "%f:%l:%c:%m"
vim.opt.guifont = "JetBrainsMono NF"
vim.opt.sessionoptions = {
    "buffers",
    "curdir",
    "tabpages",
    "winsize",
    "help",
    "globals",
    "skiprtp",
    "folds",
}
vim.opt.shortmess:append({ W = true, I = true, c = true, C = true })
vim.opt.wildmode = "longest:full,full"
vim.opt.virtualedit = "block"
vim.opt.signcolumn = "yes"
vim.opt.inccommand = "split"
vim.opt.clipboard = "unnamedplus"
vim.opt.jumpoptions = "view"
vim.opt.timeoutlen = 300
vim.opt.conceallevel = 2
vim.opt.confirm = true
vim.opt.number = true
vim.opt.linebreak = true
vim.opt.relativenumber = true
vim.opt.ruler = false
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.shiftround = true
vim.opt.cursorline = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.splitkeep = "screen"
vim.opt.scrolloff = 4
vim.opt.sidescrolloff = 8
vim.opt.cmdheight = 1
vim.opt.termguicolors = true
vim.opt.pumblend = 10
vim.opt.pumheight = 10
vim.opt.writebackup = true
vim.opt.hlsearch = true
vim.opt.updatetime = 200
vim.opt.showmode = false
vim.opt.list = true
vim.opt.foldenable = true
vim.opt.foldcolumn = "0"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.fillchars = {
    foldopen = "",
    foldclose = "",
    fold = " ",
    foldsep = " ",
    diff = "╱",
    eob = " ",
}
