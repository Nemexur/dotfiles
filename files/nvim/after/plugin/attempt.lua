local attempt_ok, attempt = pcall(require, "attempt")
if not attempt_ok then
    return
end

local unix = vim.fn.has("unix") == 1
local path_separator = unix and "/" or "\\"

local function initial_content_fn(ext)
    return require("attempt.initial_content." .. ext)
end

attempt.setup({
    dir = (unix and "/tmp/" or vim.fn.expand("$TEMP\\")) .. "attempt.nvim" .. path_separator,
    autosave = false,
    list_buffers = false,
    initial_content = {
        lua = initial_content_fn,
        js = initial_content_fn,
        py = initial_content_fn,
        go = initial_content_fn,
        sh = initial_content_fn,
    },
    ext_options = { "lua", "js", "py", "go", "sh", "yaml", "json" },
    run = {
        lua = { "w", "luafile %" },
        js = { "w !node" },
        py = { "w !python" },
        go = { "w !go run %" },
        sh = { "w !bash" },
    },
})
