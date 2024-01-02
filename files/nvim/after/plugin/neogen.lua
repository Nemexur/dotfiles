local status_ok, neogen = pcall(require, "neogen")
if not status_ok then
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
    }
})
