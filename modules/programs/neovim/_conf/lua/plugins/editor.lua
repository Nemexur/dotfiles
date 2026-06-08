return {
    { "tpope/vim-rsi", lazy = false },
    { "tpope/vim-abolish", lazy = false },
    { "tpope/vim-eunuch", event = "VeryLazy" },
    {
        "nvim-mini/mini.indentscope",
        version = false,
        event = "VeryLazy",
        opts = function()
            return {
                symbol = "│",
                draw = {
                    delay = 0,
                    animation = require("mini.indentscope").gen_animation.none(),
                },
            }
        end,
    },
    {
        "nvim-mini/mini.ai",
        version = false,
        event = "VeryLazy",
        dependencies = { "nvim-mini/mini.extra" },
        opts = function()
            require("mini.extra").setup()
            local ai = require("mini.ai")
            return {
                n_lines = 500,
                custom_textobjects = {
                    o = ai.gen_spec.treesitter({ -- code block
                        a = { "@block.outer", "@conditional.outer", "@loop.outer" },
                        i = { "@block.inner", "@conditional.inner", "@loop.inner" },
                    }),
                    f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }), -- function
                    c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }), -- class
                    ["/"] = ai.gen_spec.treesitter({ a = "@comment.outer", i = "@comment.inner" }), -- comment
                    t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" }, -- tags
                    e = { -- Word with case
                        {
                            "%u[%l%d]+%f[^%l%d]",
                            "%f[%S][%l%d]+%f[^%l%d]",
                            "%f[%P][%l%d]+%f[^%l%d]",
                            "^[%l%d]+%f[^%l%d]",
                        },
                        "^().*()$",
                    },
                    u = ai.gen_spec.function_call(), -- u for "Usage"
                    U = ai.gen_spec.function_call({ name_pattern = "[%w_]" }), -- without dot in function name
                    -- From MiniExtra
                    B = MiniExtra.gen_ai_spec.buffer(),
                    D = MiniExtra.gen_ai_spec.diagnostic(),
                    I = MiniExtra.gen_ai_spec.indent(),
                    L = MiniExtra.gen_ai_spec.line(),
                    N = MiniExtra.gen_ai_spec.number(),
                },
            }
        end,
    },
    {
        "kevinhwang91/nvim-bqf",
        ft = "qf",
        dependencies = { "junegunn/fzf" },
        opts = { preview = { winblend = 0 } },
    },
    {
        "stevearc/quicker.nvim",
        ft = "qf",
        opts = {
            keys = {
                {
                    ">",
                    function()
                        require("quicker").expand({ before = 2, after = 2, add_to_existing = true })
                        vim.api.nvim_win_set_height(0, math.min(20, vim.api.nvim_buf_line_count(0)))
                    end,
                    desc = "Expand quickfix context",
                },
                {
                    "<",
                    function()
                        require("quicker").collapse()
                    end,
                    desc = "Collapse quickfix context",
                },
            },
        },
        keys = {
            {
                "<leader>qq",
                function()
                    require("quicker").toggle({ focus = true })
                end,
                desc = "Toggle [Q]uickfix List",
            },
            {
                "<leader>ql",
                function()
                    require("quicker").toggle({ loclist = true, focus = true })
                end,
                desc = "Toggle [L]oclist",
            },
        },
    },
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        opts = {
            label = {
                rainbow = { enabled = true },
            },
            modes = {
                char = {
                    multi_line = false,
                    jump_labels = true,
                    highlight = { backdrop = false },
                    jump = { autojump = true },
                },
                search = {
                    enabled = true,
                },
            },
        },
        keys = {
            {
                "ss",
                mode = { "n", "o", "x" },
                function()
                    require("flash").jump()
                end,
                desc = "Flash",
            },
            {
                "S",
                mode = { "n", "o", "x" },
                function()
                    require("flash").treesitter()
                end,
                desc = "Flash Treesitter",
            },
            {
                "r",
                mode = "o",
                function()
                    require("flash").remote()
                end,
                desc = "Remote Flash",
            },
            {
                "R",
                mode = { "o" },
                function()
                    require("flash").treesitter_search()
                end,
                desc = "Treesitter Search",
            },
            {
                "<c-s>",
                mode = { "c" },
                function()
                    require("flash").toggle()
                end,
                desc = "Toggle Flash Search",
            },
        },
    },
    {
        "gbprod/yanky.nvim",
        dependencies = { "folke/snacks.nvim" },
        opts = {},
        keys = {
            {
                "<leader>sy",
                function()
                    Snacks.picker.yanky()
                end,
                mode = { "n", "x" },
                desc = "Yank History",
            },
            {
                "y",
                "<Plug>(YankyYank)",
                mode = { "n", "x" },
                desc = "Yank text",
            },
            {
                "p",
                "<Plug>(YankyPutAfter)",
                mode = { "n", "x" },
                desc = "Put yanked text after cursor",
            },
            {
                "P",
                "<Plug>(YankyPutBefore)",
                mode = { "n", "x" },
                desc = "Put yanked text before cursor",
            },
            {
                "gp",
                "<Plug>(YankyGPutAfter)",
                mode = { "n", "x" },
                desc = "Put yanked text after selection",
            },
            {
                "gP",
                "<Plug>(YankyGPutBefore)",
                mode = { "n", "x" },
                desc = "Put yanked text before selection",
            },
            { "<c-p>", "<Plug>(YankyPreviousEntry)", desc = "Select previous entry through yank history" },
            { "<c-n>", "<Plug>(YankyNextEntry)", desc = "Select next entry through yank history" },
            { "]p", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put indented after cursor (linewise)" },
            { "[p", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put indented before cursor (linewise)" },
            { "]P", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put indented after cursor (linewise)" },
            { "[P", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put indented before cursor (linewise)" },
            { ">p", "<Plug>(YankyPutIndentAfterShiftRight)", desc = "Put and indent right" },
            { "<p", "<Plug>(YankyPutIndentAfterShiftLeft)", desc = "Put and indent left" },
            { ">P", "<Plug>(YankyPutIndentBeforeShiftRight)", desc = "Put before and indent right" },
            { "<P", "<Plug>(YankyPutIndentBeforeShiftLeft)", desc = "Put before and indent left" },
            { "=p", "<Plug>(YankyPutAfterFilter)", desc = "Put after applying a filter" },
            { "=P", "<Plug>(YankyPutBeforeFilter)", desc = "Put before applying a filter" },
        },
    },
    {
        "danymat/neogen",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        opts = {
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
                go = {
                    template = {
                        annotation_convention = "godoc",
                    },
                },
            },
        },
        keys = {
            {
                "<leader>tc",
                "<cmd>lua require('neogen').generate({ type = 'class' })<cr>",
                desc = "[C]lass Doc",
                mode = "n",
            },
            {
                "<leader>tf",
                "<cmd>lua require('neogen').generate({ type = 'func' })<cr>",
                desc = "[F]unction Doc",
                mode = "n",
            },
            {
                "<leader>tt",
                "<cmd>lua require('neogen').generate({ type = 'type' })<cr>",
                desc = "[T]ype Doc",
                mode = "n",
            },
        },
    },
    {
        "nvim-mini/mini.surround",
        event = "VeryLazy",
        version = false,
        opts = {},
        keys = {
            { "sa", desc = "Add Surrounding", mode = { "n", "x" } },
            { "sd", desc = "Delete Surrounding" },
            { "sf", desc = "Find Right Surrounding" },
            { "sF", desc = "Find Left Surrounding" },
            { "sh", desc = "Highlight Surrounding" },
            { "sr", desc = "Replace Surrounding" },
        },
    },
    {
        "nvim-mini/mini.comment",
        event = "VeryLazy",
        version = false,
        opts = {},
    },
    {
        "nvim-mini/mini.splitjoin",
        event = "VeryLazy",
        version = false,
        opts = {
            mappings = {
                toggle = "gs",
                split = "",
                join = "",
            },
        },
    },
    {
        "nvim-mini/mini.align",
        event = "VeryLazy",
        version = false,
        opts = {},
    },
    {
        "echasnovski/mini.pairs",
        event = "InsertEnter",
        version = false,
        opts = {},
    },
    {
        "gbprod/substitute.nvim",
        opts = {},
        keys = {
            {
                "<leader>p",
                "<cmd>lua require('substitute').operator()<cr>",
                desc = "Substitute",
                mode = "n",
            },
            {
                "<leader>p",
                "<cmd>lua require('substitute').visual()<cr>",
                desc = "Substitute",
                mode = "x",
            },
        },
    },
    {
        "monaqa/dial.nvim",
        config = function()
            local augend = require("dial.augend")
            require("dial.config").augends:register_group({
                default = {
                    augend.integer.alias.decimal_int,
                    augend.integer.alias.hex,
                    augend.date.alias["%Y/%m/%d"],
                    augend.date.alias["%Y-%m-%d"],
                    augend.date.alias["%m/%d"],
                    augend.date.alias["%H:%M"],
                    augend.constant.alias.bool,
                    augend.constant.alias.Bool,
                    augend.semver.alias.semver,
                    augend.constant.alias.en_weekday,
                    augend.constant.alias.en_weekday_full,
                    augend.constant.new({ elements = { "and", "or" }, word = true, cyclic = true }),
                    augend.constant.new({ elements = { "&&", "||" }, word = false, cyclic = true }),
                },
            })
        end,
        keys = {
            {
                "<C-a>",
                function()
                    return require("dial.map").manipulate("increment", "normal")
                end,
                desc = "Increment",
            },
            {
                "<C-x>",
                function()
                    return require("dial.map").manipulate("decrement", "normal")
                end,
                desc = "Decrement",
            },
            {
                "g<C-a>",
                function()
                    return require("dial.map").manipulate("increment", "gnormal")
                end,
                desc = "gIncrement",
            },
            {
                "g<C-x>",
                function()
                    return require("dial.map").manipulate("decrement", "gnormal")
                end,
                desc = "gDecrement",
            },
            {
                "<C-a>",
                function()
                    return require("dial.map").manipulate("increment", "visual")
                end,
                mode = { "v" },
                desc = "Increment",
            },
            {
                "<C-x>",
                function()
                    return require("dial.map").manipulate("decrement", "visual")
                end,
                mode = { "v" },
                desc = "Decrement",
            },
            {
                "g<C-a>",
                function()
                    return require("dial.map").manipulate("increment", "gvisual")
                end,
                mode = { "v" },
                desc = "gIncrement",
            },
            {
                "g<C-x>",
                function()
                    return require("dial.map").manipulate("decrement", "gvisual")
                end,
                mode = { "v" },
                desc = "gDecrement",
            },
        },
    },
    {
        "christoomey/vim-tmux-navigator",
        cmd = {
            "TmuxNavigateLeft",
            "TmuxNavigateDown",
            "TmuxNavigateUp",
            "TmuxNavigateRight",
            "TmuxNavigatePrevious",
        },
        keys = {
            { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
            { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
            { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
            { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
            { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
        },
    },
}
