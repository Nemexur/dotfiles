local function augroup(name)
    return vim.api.nvim_create_augroup("nemexur_" .. name, { clear = true })
end

-- check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
    group = augroup("checktime"),
    callback = function()
        if vim.o.buftype ~= "nofile" then
            vim.cmd("checktime")
        end
    end,
})

-- highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    group = augroup("highlight_yank"),
    callback = function()
        (vim.hl or vim.highlight).on_yank()
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

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
    group = augroup("last_loc"),
    callback = function(event)
        local exclude = { "gitcommit" }
        local buf = event.buf
        if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].nvim_last_loc then
            return
        end
        vim.b[buf].nvim_last_loc = true
        local mark = vim.api.nvim_buf_get_mark(buf, '"')
        local lcount = vim.api.nvim_buf_line_count(buf)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
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
        "notify",
        "qf",
        "query",
        "null-ls-info",
        "spectre_panel",
        "startuptime",
        "checkhealth",
        "grug-far",
    },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.schedule(function()
            vim.keymap.set("n", "q", function()
                vim.cmd("close")
                pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
            end, {
                buffer = event.buf,
                silent = true,
                desc = "Quit buffer",
            })
        end)
    end,
})

-- close hist filetype with q
vim.api.nvim_create_autocmd("FileType", {
    group = augroup("close_hist_with_q"),
    pattern = { "hist" },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.schedule(function()
            vim.keymap.set("n", "q", function() vim.cmd("qa") end)
        end)
    end,
})

-- make it easier to close man-files when opened inline
vim.api.nvim_create_autocmd("FileType", {
    group = augroup("man_unlisted"),
    pattern = { "man" },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
    end,
})

-- Fix conceallevel for json files
vim.api.nvim_create_autocmd({ "FileType" }, {
    group = augroup("json_conceal"),
    pattern = { "json", "jsonc", "json5" },
    callback = function()
        vim.opt_local.conceallevel = 0
    end,
})

-- auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    group = augroup("auto_create_dir"),
    callback = function(event)
        if event.match:match("^%w%w+:[\\/][\\/]") then
            return
        end
        local file = vim.uv.fs_realpath(event.match) or event.match
        vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
    end,
})

-- remove trailing whitespaces when saving the file
vim.api.nvim_create_autocmd("BufWritePre", {
    group = augroup("remove_trailing_whitespaces"),
    pattern = { "*" },
    command = [[%s/\s\+$//e]],
})

-- set yaml.docker-compose filetype
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    group = augroup("docker_compose"),
    pattern = { "docker-compose.yml", "docker-compose.yaml" },
    callback = function()
        vim.bo.filetype = "yaml.docker-compose"
    end,
})

-- set yaml.gitlab filetype
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    group = augroup("gitlab-ci"),
    pattern = "*.gitlab-ci*.{yml,yaml}",
    callback = function()
        vim.bo.filetype = "yaml.gitlab"
    end,
})

-- set yaml.ansible filetype for particular yaml files
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    group = augroup("ansible"),
    pattern = {
        "main.yml",
        "main.yaml",
        "requirements.yml",
        "requirements.yaml",
        "playbook.yml",
        "playbook.yaml",
        "*/host_vars/*.yml",
        "*/host_vars/*.yaml",
        "*/group_vars/*.yml",
        "*/group_vars/*.yaml",
        "*/group_vars/*/*.yml",
        "*/group_vars/*/*.yaml",
        "*/playbooks/*.yml",
        "*/playbooks/*.yaml",
        "*/roles/*/tasks/*.yml",
        "*/roles/*/tasks/*.yaml",
        "*/roles/*/handlers/*.yml",
        "*/roles/*/handlers/*.yaml",
    },
    callback = function()
        vim.bo.filetype = "yaml.ansible"
    end,
})

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

-- Configure LspAttach
vim.api.nvim_create_autocmd("LspAttach", {
    group = augroup("lsp-attach"),
    callback = function(event)
        local map = function(keys, func, desc, mode)
            mode = mode or "n"
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = desc })
        end

        map("K", vim.lsp.buf.hover, "Hover")
        map("<c-s>", vim.lsp.buf.signature_help, "Signature Help")
        map("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
        map("grr", vim.lsp.buf.references, "[G]oto [R]eferences")
        map("gri", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
        map("grn", vim.lsp.buf.rename, "[R]ename")
        map("gra", vim.lsp.buf.code_action, "Code [A]ction", { "n", "x" })
        map("gy", vim.lsp.buf.type_definition, "Type [D]efinition")
        map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
        map("gO", vim.lsp.buf.document_symbol, "D[O]cument Symbol")
        map("gK", vim.diagnostic.open_float, "Line Diagnostic")
        map("gf", function() vim.lsp.buf.format({ async = true, timeout_ms = 10000 }) end, "[F]ormat")
        map("[d", function()
            vim.diagnostic.jump({ count = 1, float = true })
        end, "Goto Diagnostic Next")
        map("]d", function()
            vim.diagnostic.jump({ count = -1, float = true })
        end, "Goto Diagnostic Prev")
        map("<leader>ll", function()
            Snacks.picker.lsp_config()
        end, "[L]sp Info")
        map("<leader>lc", vim.lsp.codelens.run, "Run [C]odeLens")
        map("<leader>lC", vim.lsp.codelens.refresh, "Refersh & Display [C]odeLens")
        map("<leader>lg", function()
            require("treesitter-context").go_to_context(vim.v.count1)
        end, "[G]oto Context")

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_codeLens) then
            vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
                group = augroup("codelens-refresh"),
                buffer = event.buf,
                callback = vim.lsp.codelens.refresh,
            })
        end
        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local highlight_augroup = augroup("lsp-highlight")
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                group = highlight_augroup,
                buffer = event.buf,
                callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                group = highlight_augroup,
                buffer = event.buf,
                callback = vim.lsp.buf.clear_references,
            })
            vim.api.nvim_create_autocmd("LspDetach", {
                group = augroup("lsp-detach"),
                callback = function(event2)
                    vim.lsp.buf.clear_references()
                    vim.api.nvim_clear_autocmds({ group = highlight_augroup, buffer = event2.buf })
                end,
            })
        end
        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            map("<leader>lh", function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
            end, "Toggle Inlay [H]ints")
        end

        local icons = { ERROR = "", WARN = "", HINT = "", INFO = "" }
        vim.diagnostic.config({
            update_in_insert = true,
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = icons.ERROR,
                    [vim.diagnostic.severity.WARN] = icons.WARN,
                    [vim.diagnostic.severity.HINT] = icons.HINT,
                    [vim.diagnostic.severity.INFO] = icons.INFO,
                },
            },
            virtual_lines = {
                current_line = true,
                format = function(diagnostic)
                    local severity = vim.diagnostic.severity[diagnostic.severity]
                    return icons[severity] .. " " .. diagnostic.message
                end,
            },
            underline = true,
            severity_sort = true,
            float = {
                source = true,
                severity_sort = true,
                focusable = true,
                style = "minimal",
                border = "rounded",
            },
        })
    end,
})
