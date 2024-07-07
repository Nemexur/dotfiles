local function augroup(name)
    return vim.api.nvim_create_augroup("nemexur_" .. name, { clear = true })
end

-- check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
    group = augroup("checktime"),
    command = "checktime",
})

-- highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    group = augroup("highlight_yank"),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd("VimResized", {
    group = augroup("resize_splits"),
    callback = function()
        local current_tab = vim.fn.tabpagenr()
        vim.cmd("tabdo wincmd =")
        vim.cmd("tabnext " .. current_tab)
    end,
})

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
    group = augroup("wrap_spell"),
    pattern = { "NeogitCommitMessage", "gitcommit" },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
    group = augroup("close_with_q"),
    pattern = {
        "PlenaryTestPopup",
        "help",
        "lspinfo",
        "man",
        "notify",
        "qf",
        "query",
        "null-ls-info",
        "spectre_panel",
        "startuptime",
        "checkhealth",
    },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
    end,
})

-- auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd("BufWritePre", {
    group = augroup("auto_create_dir"),
    callback = function(event)
        if event.match:match("^%w%w+://") then
            return
        end
        local file = vim.loop.fs_realpath(event.match) or event.match
        vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
    end,
})

-- remove trailing whitespaces when saving the file
vim.api.nvim_create_autocmd("BufWritePre", {
    group = augroup("remove_trailing_whitespaces"),
    pattern = { "*" },
    command = [[%s/\s\+$//e]],
})

-- set docker-compose filetype
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    group = augroup("docker_compose"),
    pattern = {
        "docker-compose.yml",
        "docker-compose.yaml",
    },
    callback = function()
        vim.cmd("set ft=yaml.docker-compose")
    end,
})

-- Set local settings for terminal buffers
vim.api.nvim_create_autocmd("TermOpen", {
    group = augroup("custom-term-open"),
    callback = function()
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        vim.opt_local.scrolloff = 0
    end,
})

-- Disable terminal when recovering from session manager
vim.api.nvim_create_user_command("TermKill", function()
    if vim.g.term_win_id ~= nil then
        vim.api.nvim_win_close(vim.g.term_win_id, true)
        vim.g.term_win_id = nil
    end
    if vim.g.term_buf_id ~= nil then
        vim.api.nvim_buf_delete(vim.g.term_buf_id, { force = true })
        vim.g.term_buf_id = nil
    end
end, {})

-- enables lsp inlay hints
-- vim.api.nvim_create_autocmd("LspAttach", {
--     group = augroup("lsp_inlay_hints"),
--     callback = function(event)
--         if not (event.data and event.data.client_id) then
--             return
--         end
--         local bufnr = event.buf
--         local client = vim.lsp.get_client_by_id(event.data.client_id)
--         require("lsp-inlayhints").on_attach(client, bufnr)
--     end,
-- })
