return {
    { "tpope/vim-rsi",       lazy = false },
    { "tpope/vim-abolish",   lazy = false },
    { "tpope/vim-eunuch",    event = "VeryLazy" },
    { "echasnovski/mini.ai", version = false,   event = "VeryLazy" },
    {
        "kevinhwang91/nvim-bqf",
        ft = "qf",
        opts = {
            preview = {
                winblend = 0,
            },
        },
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
                desc = "Toggle Quickfix List",
            },
            {
                "<leader>ql",
                function()
                    require("quicker").toggle({ loclist = true, focus = true })
                end,
                desc = "Toggle Loclist",
            },
        },
    },
    {
        "numToStr/Comment.nvim",
        keys = {
            { "gc", mode = { "n", "v" } },
            { "gb", mode = { "n", "v" } },
        },
        opts = {},
    },
    {
        "jinh0/eyeliner.nvim",
        event = "VeryLazy",
        opts = { highlight_on_key = true, dim = true },
    },
    {
        "folke/flash.nvim",
        opts = {
            label = {
                rainbow = {
                    enabled = true,
                },
            },
            highlight = {
                priority = 9000,
            },
            modes = {
                char = {
                    autohide = true,
                    highlight = { backdrop = false },
                },
            },
        },
        keys = {
            {
                "<C-f>",
                "<cmd>lua require('flash').jump()<cr>",
                desc = "Flash jump",
                mode = { "n", "x", "o" },
            },
            {
                "r",
                "<cmd>lua require('flash').treesitter_search()<cr>",
                desc = "Flash Treesitter Search",
                mode = { "x", "o" },
            },
        },
    },
    {
        "gbprod/yanky.nvim",
        dependencies = { "folke/snacks.nvim" },
        opts = {},
        keys = {
            {
                "<leader>p",
                function()
                    Snacks.picker.yanky()
                end,
                mode = { "n", "x" },
                desc = "Open Yank History",
            },
            { "y",     "<Plug>(YankyYank)",                      mode = { "n", "x" },                                desc = "Yank text" },
            { "p",     "<Plug>(YankyPutAfter)",                  mode = { "n", "x" },                                desc = "Put yanked text after cursor" },
            { "P",     "<Plug>(YankyPutBefore)",                 mode = { "n", "x" },                                desc = "Put yanked text before cursor" },
            { "gp",    "<Plug>(YankyGPutAfter)",                 mode = { "n", "x" },                                desc = "Put yanked text after selection" },
            { "gP",    "<Plug>(YankyGPutBefore)",                mode = { "n", "x" },                                desc = "Put yanked text before selection" },
            { "<c-p>", "<Plug>(YankyPreviousEntry)",             desc = "Select previous entry through yank history" },
            { "<c-n>", "<Plug>(YankyNextEntry)",                 desc = "Select next entry through yank history" },
            { "]p",    "<Plug>(YankyPutIndentAfterLinewise)",    desc = "Put indented after cursor (linewise)" },
            { "[p",    "<Plug>(YankyPutIndentBeforeLinewise)",   desc = "Put indented before cursor (linewise)" },
            { "]P",    "<Plug>(YankyPutIndentAfterLinewise)",    desc = "Put indented after cursor (linewise)" },
            { "[P",    "<Plug>(YankyPutIndentBeforeLinewise)",   desc = "Put indented before cursor (linewise)" },
            { ">p",    "<Plug>(YankyPutIndentAfterShiftRight)",  desc = "Put and indent right" },
            { "<p",    "<Plug>(YankyPutIndentAfterShiftLeft)",   desc = "Put and indent left" },
            { ">P",    "<Plug>(YankyPutIndentBeforeShiftRight)", desc = "Put before and indent right" },
            { "<P",    "<Plug>(YankyPutIndentBeforeShiftLeft)",  desc = "Put before and indent left" },
            { "=p",    "<Plug>(YankyPutAfterFilter)",            desc = "Put after applying a filter" },
            { "=P",    "<Plug>(YankyPutBeforeFilter)",           desc = "Put before applying a filter" },
        },
    },
    {
        "gbprod/substitute.nvim",
        dependencies = { "gbprod/yanky.nvim" },
        opts = {
            on_substitute = function()
                require("yanky.integration").substitute()
            end,
        },
        keys = {
            { "s",  "<cmd>lua require('substitute').operator() <cr>", desc = "Substitute text" },
            { "ss", "<cmd>lua require('substitute').line() <cr>",     desc = "Substitute line" },
            { "S",  "<cmd>lua require('substitute').eol() <cr>",      desc = "Substitute to EOL" },
            { "s",  "<cmd>lua require('substitute').visual() <cr>",   desc = "Substitute visual", mode = "v" },
            {
                "X",
                "<cmd>lua require('substitute.exchange').visual() <cr>",
                desc = "Substitute exchange visual",
                mode = "v",
            },
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
                "<leader>ac",
                "<cmd>lua require('neogen').generate({ type = 'class' })<cr>",
                desc = "Class Doc",
                mode = "n",
            },
            {
                "<leader>af",
                "<cmd>lua require('neogen').generate({ type = 'func' })<cr>",
                desc = "Function Doc",
                mode = "n",
            },
            {
                "<leader>at",
                "<cmd>lua require('neogen').generate({ type = 'type' })<cr>",
                desc = "Type Doc",
                mode = "n",
            },
        },
    },
    {
        "kylechui/nvim-surround",
        event = "VeryLazy",
        version = "^3.0.0",
        opts = {},
    },
    {
        "Wansmer/treesj",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        opts = { use_default_keymaps = false, max_join_length = 100 },
        keys = {
            { "<leader>nn", "<cmd>lua require('treesj').toggle()<cr>", desc = "Toggle Split/Join" },
        },
    },
    {
        "monaqa/dial.nvim",
        config = function()
            local augend = require("dial.augend")
            require("dial.config").augends:register_group({
                default = {
                    augend.integer.alias.decimal,
                    augend.integer.alias.hex,
                    augend.date.alias["%Y/%m/%d"],
                    augend.date.alias["%Y-%m-%d"],
                    augend.date.alias["%m/%d"],
                    augend.date.alias["%H:%M"],
                    augend.constant.alias.bool,
                    augend.semver.alias.semver,
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
        "echasnovski/mini.pairs",
        event = "InsertEnter",
        version = false,
        opts = {},
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
            { "<c-h>",  "<cmd><C-U>TmuxNavigateLeft<cr>" },
            { "<c-j>",  "<cmd><C-U>TmuxNavigateDown<cr>" },
            { "<c-k>",  "<cmd><C-U>TmuxNavigateUp<cr>" },
            { "<c-l>",  "<cmd><C-U>TmuxNavigateRight<cr>" },
            { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
        },
    },
}
