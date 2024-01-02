local neogen_ok, neogen = pcall(require, "neogen")
if not neogen_ok then
    return
end

neogen.setup({
    snippet_engine = "luasnip",
    enabled = true,
    languages = {
        lua = {
            template = {
                annotation_convention = "emmylua",
            },
        },
        python = {
            template = {
                annotation_convention = "numpydoc",
            },
        },
        rust = {
            template = {
                annotation_convention = "rustdoc",
            },
        },
    },
})
