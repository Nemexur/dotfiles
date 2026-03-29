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
    callback = function(ev)
        local exclude = { "gitcommit" }
        local buf = ev.buf
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
    callback = function(ev)
        vim.bo[ev.buf].buflisted = false
        vim.schedule(function()
            vim.keymap.set("n", "q", function()
                vim.cmd("close")
                pcall(vim.api.nvim_buf_delete, ev.buf, { force = true })
            end, {
                buffer = ev.buf,
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
    callback = function(ev)
        vim.bo[ev.buf].buflisted = false
        vim.schedule(function()
            vim.keymap.set("n", "q", function()
                vim.cmd("qa")
            end)
        end)
    end,
})

-- make it easier to close man-files when opened inline
vim.api.nvim_create_autocmd("FileType", {
    group = augroup("man_unlisted"),
    pattern = { "man" },
    callback = function(ev)
        vim.bo[ev.buf].buflisted = false
    end,
})

-- fix conceallevel for json files
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

-- auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    group = augroup("auto_create_dir"),
    callback = function(ev)
        if ev.match:match("^%w%w+:[\\/][\\/]") then
            return
        end
        local file = vim.uv.fs_realpath(ev.match) or ev.match
        vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
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

-- configure treesitter
vim.api.nvim_create_autocmd("FileType", {
    group = augroup("treesitter"),
    pattern = {
        "bash",
        "c",
        "dockerfile",
        "gitcommit",
        "gitignore",
        "go",
        "gomod",
        "gosum",
        "helm",
        "html",
        "javascript",
        "jsdoc",
        "json",
        "jsonnet",
        "latex",
        "lua",
        "luadoc",
        "luap",
        "make",
        "markdown_inline",
        "markdown",
        "proto",
        "python",
        "regex",
        "sql",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "xml",
        "yaml.ansible",
        "yaml.docker-compose",
        "yaml.gitlab",
        "yaml",
        "zsh",
    },
    callback = function()
        -- syntax highlighting, provided by Neovim
        vim.treesitter.start()
        -- folds, provided by Neovim
        vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
        vim.wo.foldmethod = "expr"
        -- indentation, provided by nvim-treesitter
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
})

-- set up lsp servers.
vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
    once = true,
    callback = function()
        local servers = vim.iter(vim.api.nvim_get_runtime_file("lsp/*.lua", true))
            :map(function(file)
                return vim.fn.fnamemodify(file, ":t:r")
            end)
            :filter(function(name)
                return name ~= "ty"
            end)
            :totable()
        vim.lsp.enable(servers)
    end,
})

-- configure lspattach
vim.api.nvim_create_autocmd("LspAttach", {
    group = augroup("lsp-attach"),
    callback = function()
        local ms = vim.lsp.protocol.Methods

        Snacks.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover", lsp = { method = ms.textDocument_hover } })
        Snacks.keymap.set(
            "n",
            "<c-s>",
            vim.lsp.buf.signature_help,
            { desc = "Signature Help", lsp = { method = ms.textDocument_signatureHelp } }
        )
        Snacks.keymap.set(
            "n",
            "gd",
            vim.lsp.buf.definition,
            { desc = "[G]oto [D]efinition", lsp = { method = ms.textDocument_definition } }
        )
        Snacks.keymap.set(
            "n",
            "grr",
            vim.lsp.buf.references,
            { desc = "[G]oto [R]eferences", lsp = { method = ms.textDocument_references } }
        )
        Snacks.keymap.set(
            "n",
            "gri",
            vim.lsp.buf.implementation,
            { desc = "[G]oto [I]mplementation", lsp = { method = ms.textDocument_implementation } }
        )
        Snacks.keymap.set(
            "n",
            "grn",
            vim.lsp.buf.rename,
            { desc = "[R]ename", lsp = { method = ms.textDocument_rename } }
        )
        Snacks.keymap.set(
            { "n", "x" },
            "gra",
            vim.lsp.buf.code_action,
            { desc = "Code [A]ction", lsp = { method = ms.textDocument_codeAction } }
        )
        Snacks.keymap.set(
            "n",
            "gy",
            vim.lsp.buf.type_definition,
            { desc = "Type [D]efinition", lsp = { method = ms.textDocument_typeDefinition } }
        )
        Snacks.keymap.set(
            "n",
            "gD",
            vim.lsp.buf.declaration,
            { desc = "[G]oto [D]eclaration", lsp = { method = ms.textDocument_declaration } }
        )
        Snacks.keymap.set(
            "n",
            "gO",
            vim.lsp.buf.document_symbol,
            { desc = "D[O]cument Symbol", lsp = { method = ms.textDocument_documentSymbol } }
        )
        Snacks.keymap.set(
            "n",
            "<leader>lc",
            vim.lsp.codelens.run,
            { desc = "Run [C]odeLens", lsp = { method = ms.textDocument_codeLens } }
        )
        Snacks.keymap.set(
            "n",
            "<leader>lC",
            vim.lsp.codelens.refresh,
            { desc = "Refersh & Display [C]odeLens", lsp = { method = ms.textDocument_codeLens } }
        )
        Snacks.keymap.set("n", "gK", vim.diagnostic.open_float, { desc = "Line Diagnostic" })
        Snacks.keymap.set("n", "gf", function()
            local has_conform, conform = pcall(require, "conform")
            local formatter = has_conform and conform or vim.lsp.buf
            formatter.format({ async = true })
        end, { desc = "[F]ormat" })
        Snacks.keymap.set("n", "[d", function()
            vim.diagnostic.jump({ count = 1, float = true })
        end, { desc = "Goto Diagnostic Next" })
        Snacks.keymap.set("n", "]d", function()
            vim.diagnostic.jump({ count = -1, float = true })
        end, { desc = "Goto Diagnostic Prev" })
        Snacks.keymap.set("n", "<leader>ll", function()
            Snacks.picker.lsp_config()
        end, { desc = "[L]sp Info" })

        Snacks.toggle.inlay_hints():map("<leader>lh")
        Snacks.util.lsp.on({ method = ms.textDocument_inlayHint }, function(buffer)
            local group = augroup("inlay_hint")
            vim.api.nvim_create_autocmd("InsertEnter", {
                group = group,
                desc = "Enable inlay hints",
                buffer = buffer,
                callback = function(ev)
                    if vim.lsp.inlay_hint.is_enabled({ bufnr = ev.buf }) then
                        vim.lsp.inlay_hint.enable(false, { bufnr = ev.buf })
                    end
                end,
            })
            vim.api.nvim_create_autocmd("InsertLeave", {
                group = group,
                desc = "Disable inlay hints",
                buffer = buffer,
                callback = function(ev)
                    if vim.lsp.inlay_hint.is_enabled({ bufnr = ev.buf }) then
                        vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
                    end
                end,
            })
        end)

        Snacks.util.lsp.on({ method = ms.textDocument_foldingRange }, function()
            vim.api.nvim_set_option_value("foldexpr", "v:lua.vim.lsp.foldexpr()", { scope = "local" })
        end)

        Snacks.util.lsp.on({ method = ms.textDocument_codeLens }, function(buffer)
            vim.lsp.codelens.refresh()
            vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
                group = augroup("codelens"),
                buffer = buffer,
                callback = vim.lsp.codelens.refresh,
            })
        end)

        Snacks.util.lsp.on({ method = ms.textDocument_documentHighlight }, function(buffer)
            local highlight_augroup = augroup("lsp-highlight")
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                group = highlight_augroup,
                buffer = buffer,
                callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                group = highlight_augroup,
                buffer = buffer,
                callback = vim.lsp.buf.clear_references,
            })
            vim.api.nvim_create_autocmd("LspDetach", {
                group = augroup("lsp-detach"),
                callback = function(ev)
                    vim.lsp.buf.clear_references()
                    vim.api.nvim_clear_autocmds({ group = highlight_augroup, buffer = ev.buf })
                end,
            })
        end)

        local diagnostics_icons = { ERROR = "", WARN = "", HINT = "", INFO = "" }
        vim.diagnostic.config({
            update_in_insert = true,
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = diagnostics_icons.ERROR,
                    [vim.diagnostic.severity.WARN] = diagnostics_icons.WARN,
                    [vim.diagnostic.severity.HINT] = diagnostics_icons.HINT,
                    [vim.diagnostic.severity.INFO] = diagnostics_icons.INFO,
                },
            },
            virtual_lines = {
                current_line = true,
                format = function(diagnostic)
                    local severity = vim.diagnostic.severity[diagnostic.severity]
                    return diagnostics_icons[severity] .. " " .. diagnostic.message
                end,
            },
            underline = true,
            severity_sort = true,
            float = {
                source = "if_many",
                -- Show severity icons as prefixes.
                prefix = function(diag)
                    local level = vim.diagnostic.severity[diag.severity]
                    local prefix = string.format(" %s ", diagnostics_icons[level])
                    return prefix, "Diagnostic" .. level:gsub("^%l", string.upper)
                end,
                severity_sort = true,
                focusable = true,
                style = "minimal",
                border = "rounded",
            },
        })
    end,
})
