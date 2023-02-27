local options = {
    tabstop = 2, -- insert 2 spaces for a tab
    shiftwidth = 2, -- the number of spaces inserted for each indentation
    expandtab = true,
}
for k, v in pairs(options) do
    vim.opt_local[k] = v
end
