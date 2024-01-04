vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0

local opts = {
    mouse = "a",
    fileencoding = "utf-8",
    spelllang = { "en", "ru" },
    undofile = true,
    undodir = os.getenv("HOME") .. "/.vim/undodir",
    grepprg = "rg --vimgrep",
    grepformat = "%f:%l:%c:%m",
    guifont = "JetBrainsMono NF",
    sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" },
    formatoptions = "jcroqlnt", -- tcqj
    clipboard = "unnamedplus", -- Sync with system clipboard
    timeoutlen = 300, -- Time in milliseconds to wait for a mapped sequence to complete.
    conceallevel = 3, -- Hide * markup for bold and italic
    confirm = true, -- Confirm to save changes before exiting modified buffer
    number = true, -- Print line number
    relativenumber = true, -- Relative line numbers
    ignorecase = true, -- Ignore case
    expandtab = true, -- Use spaces instead of tabs
    tabstop = 4, -- Number of spaces tabs count for
    shiftwidth = 4, -- Size of an indent
    shiftround = true, -- Round indent
    cursorline = true, -- Enable highlighting of the current line
    smartcase = true, -- Don't ignore case with capitals
    smartindent = true, -- Insert indents automatically
    splitbelow = true, -- Put new windows below current
    splitright = true, -- Put new windows right of current
    splitkeep = "screen", -- Keep the text on the same screen line
    scrolloff = 4, -- Lines to keep above and below the cursor
    sidescrolloff = 8, -- Columns to keep to the left and to the right
    cmdheight = 1, -- Lines to use for command-line
    termguicolors = true, -- Enables 24-bit RGB color in the TUI
    pumheight = 10, -- Maximum number of entries in a popup
    writebackup = true, -- Make a backup before overwriting a file
    hlsearch = true, -- Highlight search matches
    updatetime = 200, -- Save swap file and trigger CursorHold
    showmode = false, -- Dont show mode since we have a statusline
    list = true, -- Show some invisible characters (tabs...
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
