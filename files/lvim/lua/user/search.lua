local function _1_()
    local search = vim.api.nvim_get_hl(0, { name = "Search" })
    vim.api.nvim_set_hl(0, "CurSearch", { link = "IncSearch" })
    vim.api.nvim_set_hl(0, "SearchCurrentN", search)
    return vim.api.nvim_set_hl(0, "Search", { link = "SearchCurrentN" })
end
vim.api.nvim_create_autocmd("ColorScheme", { callback = _1_ })
local function _2_()
    vim.opt.hlsearch = true
    vim.opt.incsearch = true
    return vim.api.nvim_set_hl(0, "Search", { link = "SearchCurrentN" })
end
vim.api.nvim_create_autocmd("CmdlineEnter", { pattern = "/,\\?", callback = _2_ })
local function _3_()
    vim.api.nvim_set_hl(0, "Search", {})
    local function _4_()
        vim.opt.hlsearch = true
        return nil
    end
    return vim.defer_fn(_4_, 5)
end
vim.api.nvim_create_autocmd("CmdlineLeave", { pattern = "/,\\?", callback = _3_ })
local function _5_()
    local function _6_()
        return vim.cmd("nohlsearch")
    end
    return vim.schedule(_6_)
end
vim.api.nvim_create_autocmd({ "InsertEnter", "CursorMoved" }, { callback = _5_ })
local function handle_n_N(key)
    do
        local other
        local function _7_(_241)
            local _8_ = _241
            if (_8_ == "n") then
                return "N"
            elseif (_8_ == "N") then
                return "n"
            else
                return nil
            end
        end
        other = _7_
        local feed
        local function _10_(_241)
            return vim.api.nvim_feedkeys(_241, "n", true)
        end
        feed = _10_
        local _11_ = vim.v.searchforward
        if (_11_ == 0) then
            feed(other(key))
        elseif (_11_ == 1) then
            feed(key)
        else
        end
    end
    local function _13_()
        vim.opt.hlsearch = true
        return nil
    end
    return vim.defer_fn(_13_, 5)
end
local function _14_()
    return handle_n_N("n")
end
vim.keymap.set({ "n" }, "n", _14_)
local function _15_()
    return handle_n_N("N")
end
return vim.keymap.set({ "n" }, "N", _15_)
